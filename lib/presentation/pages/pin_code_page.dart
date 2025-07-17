import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:yandex_school_finance/presentation/widgets/circled_button.dart';
import 'package:yandex_school_finance/presentation/widgets/one_char_field.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({
    super.key,
    required this.onSubmitGoTo,
    this.onBiometricsPassed,
  });

  final String? Function(int pin) onSubmitGoTo;
  final String Function()? onBiometricsPassed;

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  String pinCode = "";
  bool isBiometricShown = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onBiometricsPassed != null && !isBiometricShown) {
        _showBiometricAuth();
        isBiometricShown = true;
      }
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OneCharField(char: pinCode.isNotEmpty ? pinCode[0] : "･"),
                OneCharField(char: pinCode.length > 1 ? pinCode[1] : "･"),
                OneCharField(char: pinCode.length > 2 ? pinCode[2] : "･"),
                OneCharField(char: pinCode.length > 3 ? pinCode[3] : "･"),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 3,
              children:
                  List.generate(
                    9,
                    (index) => CircledButton(
                      onPressed: _addPinChar("${index + 1}"),
                      child: Text(
                        "${index + 1}",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  )..addAll([
                    CircledButton(
                      onPressed: _removeChar,
                      child: Icon(Icons.backspace),
                    ),
                    CircledButton(
                      onPressed: _addPinChar("0"),
                      child: Text(
                        "0",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    CircledButton(
                      onPressed: _submitPin,
                      child: Icon(Icons.check),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  void Function()? _addPinChar(String char) {
    return pinCode.length < 4
        ? () => setState(() {
            pinCode += char;
          })
        : null;
  }

  void _removeChar() {
    if (pinCode.isNotEmpty) {
      setState(() {
        pinCode = pinCode.substring(0, pinCode.length - 1);
      });
    }
  }

  void _submitPin() {
    if (pinCode.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).must_enter_4_numbers),
        ),
      );
      return;
    }

    _authenticate();
  }

  void _showBiometricAuth() async {
    final isAuthenticated = await LocalAuthentication().authenticate(
      localizedReason: AppLocalizations.of(context).for_access_verify_identity,
      options: AuthenticationOptions(biometricOnly: true),
    );

    if (isAuthenticated && widget.onBiometricsPassed != null) {
      log(widget.onBiometricsPassed!().toString());
      context.go(widget.onBiometricsPassed!());
    }
  }

  void _authenticate() {
    final path = widget.onSubmitGoTo(int.parse(pinCode));
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).incorrect_pin)),
      );
    } else {
      context.go(path);
    }
  }
}
