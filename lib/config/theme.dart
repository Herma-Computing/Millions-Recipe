import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.montserratTextTheme(),
    colorScheme: const ColorScheme.light(
        onPrimaryContainer: Color(0xffF1F1F1),
        // background: Color(0xfffafafa),
        background: Colors.white,
        onBackground: Colors.white,
        primaryContainer: Colors.transparent,
        secondary: Colors.black,
        onPrimary: Colors.grey,
        secondaryContainer: Colors.white,
        onTertiary: Color(0x80303030),
        tertiary: Color(0xff303030),
        tertiaryContainer: Color.fromARGB(48, 85, 84, 84),
        onSecondaryContainer: Color(0x262E2E2E),
        onSecondary: Colors.black54));

ThemeData darkThem = ThemeData(
    navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Color.fromARGB(1, 255, 255, 255)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.white)),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.manropeTextTheme(const TextTheme(
        displayLarge: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
        bodyMedium:
            TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        displaySmall:
            TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        bodySmall:
            TextStyle(color: Colors.white, fontWeight: FontWeight.normal))),
    cardColor: const Color.fromRGBO(255, 255, 255, 0.090),
    cardTheme: const CardTheme(color: Color.fromRGBO(255, 255, 255, 0.090)),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color.fromRGBO(255, 255, 255, 0.090)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
    colorScheme: const ColorScheme.dark(
        onPrimaryContainer: Color(0x19ffffff),
        primaryContainer: Color(0x19ffffff),
        secondaryContainer: Color.fromRGBO(255, 255, 255, 0.090),
        primary: Color(0xff115046),
        background: Color(0xff115046),
        onBackground: Color(0xff115046),
        secondary: Colors.white,

        // onTertiary: Color(0x80303030),
        // tertiary: Colors.white38,
        tertiaryContainer: Colors.grey,
        onSecondaryContainer: Color.fromRGBO(255, 255, 255, 0.090),
        onPrimary: Colors.white,
        onSecondary: Colors.white));
