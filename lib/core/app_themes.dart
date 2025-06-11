import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
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
  );

  static final darkTheme = ThemeData();
}
