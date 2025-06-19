import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
      color: Color(0xff2AE881),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        color: Color(0xff1D1B20),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.grey.shade200,
      indicatorColor: Color(0xffD4FAE6),
      iconTheme: WidgetStateProperty.fromMap({
        WidgetState.selected: IconThemeData(color: Color(0xff2AE881)),
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
      backgroundColor: Color(0xff2AE881),
      foregroundColor: Colors.white,
      elevation: 0,
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
        selectedBackgroundColor: Color(0xff2AE881),
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
  );

  static final darkTheme = ThemeData();
}
