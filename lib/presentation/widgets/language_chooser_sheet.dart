import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/presentation/blocs/material_app_cubit.dart';

class LanguageChooserSheet extends StatelessWidget {
  const LanguageChooserSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        children: [
          ListTile(
            title: Text("Русский"),
            onTap: _localeChanged(context, const Locale("ru")),
          ),
          ListTile(
            title: Text("English"),
            onTap: _localeChanged(context, const Locale("en")),
          ),
        ],
      ),
    );
  }

  void Function() _localeChanged(BuildContext context, Locale locale) {
    void inner() {
      context.read<MaterialAppCubit>().changeLocale(locale);
      Navigator.pop(context);
    }

    return inner;
  }
}
