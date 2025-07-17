import 'package:flutter/material.dart';

class AppThemes {
  static late Color primaryColor;

  static ColorScheme get lightColorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Color(0xffD4FAE6),
    onSecondary: Colors.pink,
    error: Colors.red,
    onError: Colors.black,
    surface: AppThemes.primaryColor,
    onSurface: Color(0xff1D1B20),
  );

  static ThemeData get lightTheme => ThemeData.light().copyWith(
    colorScheme: lightColorScheme,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        color: lightColorScheme.onSurface,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.grey.shade200,
      indicatorColor: Color.lerp(primaryColor, Colors.white, 0.8),
      iconTheme: WidgetStateProperty.fromMap({
        WidgetState.selected: IconThemeData(color: primaryColor),
      }),
      labelTextStyle: WidgetStateProperty.fromMap({
        WidgetState.selected: TextStyle(fontWeight: FontWeight.w600),
        WidgetState.any: TextStyle(fontWeight: FontWeight.w500),
      }),
    ),
    listTileTheme: ListTileThemeData(
      leadingAndTrailingTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      shape: Border.symmetric(
        horizontal: BorderSide(width: 0.5, color: Colors.grey),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: CircleBorder(),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        iconColor: Colors.grey,
        iconSize: 17,
        disabledForegroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        selectedForegroundColor: lightColorScheme.onSurface,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Color(0xffD4FAE6),
      rangePickerBackgroundColor: Color(0xffD4FAE6),
      rangeSelectionBackgroundColor: Color(0xff2AE881),
      dayBackgroundColor: WidgetStateProperty.fromMap({
        WidgetState.selected: Color(0xff2AE881),
      }),
      dayForegroundColor: WidgetStateProperty.fromMap({
        WidgetState.selected: Colors.black,
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
      ),
    ),
    snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.green),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateColor.fromMap({
        WidgetState.selected: lightColorScheme.surface,
        WidgetState.any: Colors.grey,
      }),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightColorScheme.primary,
    ),
  );

  static ColorScheme get darkColorScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff121212),
    onPrimary: Colors.white,
    secondary: Color(0xff003820),
    onSecondary: Color(0xffB0E6C4),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surface: primaryColor,
    onSurface: Color(0xffE6E1E5),
  );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        color: darkColorScheme.onSurface,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Color.lerp(primaryColor, Colors.black, 0.8),
      backgroundColor: Color(0xff1F1F1F),
      iconTheme: WidgetStateProperty.fromMap({
        WidgetState.selected: IconThemeData(color: primaryColor),
      }),
      labelTextStyle: WidgetStateProperty.fromMap({
        WidgetState.selected: TextStyle(fontWeight: FontWeight.w600),
        WidgetState.any: TextStyle(fontWeight: FontWeight.w500),
      }),
    ),
    listTileTheme: ListTileThemeData(
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 18,
        color: darkColorScheme.secondary,
      ),
      shape: Border.symmetric(
        horizontal: BorderSide(width: 0.5, color: Colors.grey.shade800),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff2AE881),
      foregroundColor: Colors.black,
      elevation: 0,
      shape: CircleBorder(),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        iconColor: Colors.grey.shade300,
        iconSize: 17,
        disabledForegroundColor: Colors.grey.shade600,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        selectedForegroundColor: Colors.black,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Color(0xff003820),
      rangePickerBackgroundColor: Color(0xff003820),
      rangeSelectionBackgroundColor: Color(0xff2AE881),
      dayBackgroundColor: WidgetStateProperty.fromMap({
        WidgetState.selected: Color(0xff2AE881),
      }),
      dayForegroundColor: WidgetStateProperty.fromMap({
        WidgetState.selected: Colors.black,
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
      ),
    ),
    snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: darkColorScheme.surface,
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateColor.fromMap({
        WidgetState.selected: darkColorScheme.surface,
        WidgetState.any: Colors.grey.shade700,
      }),
    ),
  );
}
