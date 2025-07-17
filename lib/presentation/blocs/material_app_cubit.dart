import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_school_finance/core/app_themes.dart';
import 'package:yandex_school_finance/core/service_locator.dart';

class MaterialAppCubit extends Cubit<MaterialAppState> {
  MaterialAppCubit() : super(MaterialAppState());

  bool isAuthenticated = false;

  /// Getting from Shared Preferences
  ThemeMode themeMode = ThemeMode.light;
  Color get primaryColor => AppThemes.primaryColor;
  int currentHapticLevel = 0;
  bool isPinSet = false;
  Locale locale = Locale("ru");
  bool? isBiometricEnabled;

  void loadFromSharedPreferences() {
    final sharedPref = sl.get<SharedPreferences>();
    themeMode = ThemeMode.values.byName(
      sharedPref.getString("Theme") ?? 'light',
    );
    AppThemes.primaryColor = Color(
      sharedPref.getInt("PrimaryColor") ?? 0xff2AE881,
    );
    currentHapticLevel = sharedPref.getInt("HapticLevel") ?? 0;
    isPinSet = sharedPref.getInt("PIN") != null;

    if (!isPinSet) {
      isAuthenticated = true;
    }

    locale = Locale(sharedPref.getString("Locale") ?? "ru");

    LocalAuthentication().getAvailableBiometrics().then((availableBiometrics) {
      if (availableBiometrics.isNotEmpty) {
        isBiometricEnabled = sharedPref.getBool("Biometrics") ?? false;
      }
      emit(MaterialAppState());
    });

    emit(MaterialAppState());
  }

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    sl.get<SharedPreferences>().setString("Theme", mode.name);
    emit(MaterialAppState());
  }

  void changePrimaryColor(Color color) {
    AppThemes.primaryColor = color;
    sl.get<SharedPreferences>().setInt("PrimaryColor", color.toARGB32());
    emit(MaterialAppState());
  }

  void triggerHapticFeedback([int? hapticLevel]) {
    hapticLevel ??= currentHapticLevel;
    switch (hapticLevel) {
      case 0:
        return;
      case 1:
        HapticFeedback.lightImpact();
        return;
      case 2:
        HapticFeedback.mediumImpact();
        return;
      case 3:
        HapticFeedback.heavyImpact();
        return;
    }
  }

  void saveHapticLevel(int newHapticLevel) {
    currentHapticLevel = newHapticLevel;
    sl.get<SharedPreferences>().setInt("HapticLevel", newHapticLevel);
    emit(MaterialAppState());
  }

  void setPin(int? pin) {
    if (pin == null) {
      sl.get<SharedPreferences>().remove("PIN");
      isPinSet = false;
    } else {
      // Better to use secure storage, but it was not required
      sl.get<SharedPreferences>().setInt("PIN", pin);
      isPinSet = true;
    }

    emit(MaterialAppState());
  }

  bool checkPin(int pin) {
    return pin == sl.get<SharedPreferences>().getInt("PIN");
  }

  void changeLocale(Locale newLocale) {
    locale = newLocale;
    sl.get<SharedPreferences>().setString("Locale", newLocale.languageCode);
    emit(MaterialAppState());
  }

  void setBiometricAuthentication(bool isOn) {
    if (isBiometricEnabled != null) {
      isBiometricEnabled = isOn;
      sl.get<SharedPreferences>().setBool("Biometrics", isOn);
    } else if (isOn == false) {
      sl.get<SharedPreferences>().remove("Biometrics"); // just in case
    } else {
      throw Exception("Biometric authentication is not available");
    }

    emit(MaterialAppState());
  }

  void auth([bool isAuth = true]) {
    isAuthenticated = isAuth;
    emit(MaterialAppState());
  }
}

class MaterialAppState {}
