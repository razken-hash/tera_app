import 'package:flutter/material.dart';
import 'package:tera_app/screens/themes/tera_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  dividerColor: const Color(0xFFE9F0FD),
  fontFamily: "ElMessiri",
  primaryColor: TeraColors.primaryColor,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: TeraColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: TeraColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: TeraColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: TeraColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    filled: true,
    fillColor: Color(0xFFE9F0FD),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        TeraColors.primaryColor,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xffEEEEEE),
      ),
      fixedSize: MaterialStateProperty.all<Size>(
        const Size(200, 50),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 25, fontFamily: "ElMessiri"),
      ),
    ),
  ),
);
