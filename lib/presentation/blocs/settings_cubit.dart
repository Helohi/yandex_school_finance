import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/presentation/blocs/material_app_cubit.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(CurrentSettingsState());

  void changeTheme(MaterialAppCubit materialCubit, bool toSystem) {
    materialCubit.changeTheme(toSystem ? ThemeMode.system : ThemeMode.light);
  }
}

sealed class SettingsCubitState {}

class CurrentSettingsState extends SettingsCubitState {}
