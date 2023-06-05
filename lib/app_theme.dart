import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFF396FE2);
  static const lightBackgroundColor = Color(0xFAFAFAFA);
  static const primaryDark = Color(0xFF474747);

  static get lightTheme => ThemeData.light().copyWith(
        primaryColor: lightBackgroundColor,
        scaffoldBackgroundColor: lightBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 5,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black54,
          selectedIconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 48),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 48),
            ),
          ),
        ),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontSize: 18,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  static get darkTheme => lightTheme;
}
