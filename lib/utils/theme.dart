import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MainTheme {
  static ThemeData mainThemeData = ThemeData(
  primaryColor: const Color(0xffDC6B32),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffF6D097),
    onPrimary: Color(0xff222222),
    secondary: Color(0xffFFF3E2),
    onSecondary: Color(0xff222222),
    error: Colors.redAccent,
    onError: Color(0xffFFF3E2),
    surface: Color(0xffDC6B32),
    onSurface: Color(0xff222222)
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.fredoka(
        color: const Color(0xffFFF3E2),
        fontWeight: FontWeight.bold
      ),
      displayMedium: GoogleFonts.fredoka(),
      displaySmall: GoogleFonts.poppins(),
      titleLarge: GoogleFonts.fredoka(),
      titleMedium: GoogleFonts.poppins(),
      titleSmall: GoogleFonts.poppins(),
      bodyLarge: GoogleFonts.poppins(),
      bodyMedium: GoogleFonts.poppins(),
      bodySmall: GoogleFonts.poppins(),
      headlineLarge: GoogleFonts.fredoka(),
      labelLarge: GoogleFonts.poppins(),
      labelMedium: GoogleFonts.poppins(),
      labelSmall: GoogleFonts.poppins()
    )
);
}

