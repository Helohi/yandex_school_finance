import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:yandex_school_finance/presentation/blocs/material_app_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/settings_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/language_chooser_sheet.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).system_theme),
            trailing: Switch(
              value:
                  context.watch<MaterialAppCubit>().themeMode ==
                  ThemeMode.system,
              onChanged: (toSystem) => context
                  .read<SettingsCubit>()
                  .changeTheme(context.read(), toSystem),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).main_color),
                Container(
                  width: 24,
                  height: 24,
                  color: context.watch<MaterialAppCubit>().primaryColor,
                ),
              ],
            ),
            onTap: () => _showColorPicker(context),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).haptics),
            trailing: Icon(Icons.arrow_right),
            onTap: () => _chooseHapticLevel(context),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).pin_code),
            trailing: Switch(
              value: context.read<MaterialAppCubit>().isPinSet,
              onChanged: _pinSwitched(context),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).biometric),
            trailing: Switch(
              value:
                  context.watch<MaterialAppCubit>().isBiometricEnabled ?? false,
              onChanged:
                  context.watch<MaterialAppCubit>().isBiometricEnabled == null
                  ? null
                  : _biometricSwitched(context),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).language),
            trailing: Icon(Icons.arrow_right),
            onTap: () => _showLanguagePicker(context),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).about_app),
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext blocContext) {
    showDialog(
      context: blocContext,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: blocContext.watch<MaterialAppCubit>().primaryColor,
            onColorChanged: blocContext
                .read<MaterialAppCubit>()
                .changePrimaryColor,
          ),
        ),
      ),
    );
  }

  void _chooseHapticLevel(BuildContext blocContext) {
    showModalBottomSheet(
      context: blocContext,
      showDragHandle: true,
      builder: (context) => HapticLevelChooserSheet(
        initialHapticLevel: blocContext
            .read<MaterialAppCubit>()
            .currentHapticLevel,
        triggerHaptic: blocContext
            .read<MaterialAppCubit>()
            .triggerHapticFeedback,
        saveHaptic: blocContext.read<MaterialAppCubit>().saveHapticLevel,
      ),
    );
  }

  void Function(bool) _pinSwitched(BuildContext context) {
    void inner(bool value) {
      if (value) {
        context.go("${GoRouterState.of(context).uri}/setPin");
      } else {
        context.read<MaterialAppCubit>().setPin(null);
        _biometricSwitched(context)(false);
      }
    }

    return inner;
  }

  void Function(bool) _biometricSwitched(BuildContext context) {
    void inner(bool value) async {
      if (value) {
        if (!context.read<MaterialAppCubit>().isPinSet) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(
                  context,
                ).for_biometric_authorization_you_need_pin,
              ),
            ),
          );
          return;
        }

        if (!await LocalAuthentication().authenticate(
          localizedReason: AppLocalizations.of(context).authorize_to_submit,
          options: AuthenticationOptions(biometricOnly: true),
        )) {
          return;
        }
      }

      context.read<MaterialAppCubit>().setBiometricAuthentication(value);
    }

    return inner;
  }

  void _showLanguagePicker(BuildContext blocContext) {
    showModalBottomSheet(
      context: blocContext,
      showDragHandle: true,
      builder: (context) => LanguageChooserSheet(),
    );
  }
}

class HapticLevelChooserSheet extends StatefulWidget {
  const HapticLevelChooserSheet({
    super.key,
    required this.initialHapticLevel,
    required this.triggerHaptic,
    required this.saveHaptic,
  });

  final int initialHapticLevel;
  final Function(int level) triggerHaptic;
  final Function(int level) saveHaptic;

  @override
  State<HapticLevelChooserSheet> createState() =>
      _HapticLevelChooserSheetState();
}

class _HapticLevelChooserSheetState extends State<HapticLevelChooserSheet> {
  late int _chosenHaptic;

  @override
  void initState() {
    super.initState();
    _chosenHaptic = widget.initialHapticLevel;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).no),
            trailing: _chosenHaptic == 0 ? Icon(Icons.check) : null,
            onTap: () => setState(() {
              _chosenHaptic = 0;
            }),
          ),

          ListTile(
            title: Text(AppLocalizations.of(context).light),
            trailing: _chosenHaptic == 1 ? Icon(Icons.check) : null,
            onTap: () {
              setState(() {
                _chosenHaptic = 1;
              });
              widget.triggerHaptic(_chosenHaptic);
            },
          ),

          ListTile(
            title: Text(AppLocalizations.of(context).medium),
            trailing: _chosenHaptic == 2 ? Icon(Icons.check) : null,
            onTap: () {
              setState(() {
                _chosenHaptic = 2;
              });
              widget.triggerHaptic(_chosenHaptic);
            },
          ),

          ListTile(
            title: Text(AppLocalizations.of(context).hard),
            trailing: _chosenHaptic == 3 ? Icon(Icons.check) : null,
            onTap: () {
              setState(() {
                _chosenHaptic = 3;
              });
              widget.triggerHaptic(_chosenHaptic);
            },
          ),

          ElevatedButton.icon(
            onPressed: () {
              widget.saveHaptic(_chosenHaptic);
              Navigator.pop(context);
            },
            label: Text(AppLocalizations.of(context).choose),
            icon: Icon(Icons.check_box),
          ),
        ],
      ),
    );
  }
}
