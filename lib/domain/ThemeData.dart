import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appThemeData(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,

    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark,
    ),

    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orange,
      textTheme: ButtonTextTheme.primary,
    ),

    chipTheme: const ChipThemeData(
      labelStyle: TextStyle(color: Colors.orangeAccent, fontSize: 20),
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      titleLarge: GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
