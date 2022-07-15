import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: TextTheme(
    headline1: GoogleFonts.lora(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5,
        color: Colors.black),
    headline2: GoogleFonts.lora(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5,
        color: Colors.black),
    headline3:
    GoogleFonts.lora(fontSize: 48, fontWeight: FontWeight.w400,
        color: Colors.black),
    headline4: GoogleFonts.lora(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25,
        color: Colors.black),
    headline5:
    GoogleFonts.lora(fontSize: 24, fontWeight: FontWeight.w400,
        color: Colors.black),
    headline6: GoogleFonts.lora(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15,
        color: Colors.black),
    subtitle1: GoogleFonts.lora(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15,
        color: Colors.black),
    subtitle2: GoogleFonts.lora(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
        color: Colors.black),
    bodyText1: GoogleFonts.lora(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5,
        color: Colors.black),
    bodyText2: GoogleFonts.lora(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25,
        color: Colors.black),
    button: GoogleFonts.lora(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25,
        color: Colors.black),
    caption: GoogleFonts.lora(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,
        color: Colors.black),
    overline: GoogleFonts.lora(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5,
        color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(0, 128, 128, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onPrimary: Colors.white,
        elevation: 8.0),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Color.fromRGBO(0, 128, 128, 1),
      side: BorderSide(
        color: Color.fromRGBO(0, 128, 128, 1),
        width: 2,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Color.fromRGBO(120, 176, 177, 1),
          width: 2,
        )),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.black,
  ),
  navigationRailTheme: NavigationRailThemeData(
    selectedLabelTextStyle: TextStyle(color: Colors.black),
    selectedIconTheme: IconThemeData(color: Colors.black),
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    headline1: GoogleFonts.lora(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5,
        color: Colors.white),
    headline2: GoogleFonts.lora(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5,
        color: Colors.white),
    headline3:
    GoogleFonts.lora(fontSize: 48, fontWeight: FontWeight.w400,
        color: Colors.white),
    headline4: GoogleFonts.lora(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25,
        color: Colors.white),
    headline5:
    GoogleFonts.lora(fontSize: 24, fontWeight: FontWeight.w400,
        color: Colors.white),
    headline6: GoogleFonts.lora(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15,
        color: Colors.white),
    subtitle1: GoogleFonts.lora(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15,
        color: Colors.white),
    subtitle2: GoogleFonts.lora(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
        color: Colors.white),
    bodyText1: GoogleFonts.lora(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5,
        color: Colors.white),
    bodyText2: GoogleFonts.lora(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25,
        color: Colors.white),
    button: GoogleFonts.lora(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25,
        color: Colors.white),
    caption: GoogleFonts.lora(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,
        color: Colors.white),
    overline: GoogleFonts.lora(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5,
        color: Colors.white),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(0, 128, 128, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onPrimary: Colors.white,
        elevation: 8.0),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Color.fromRGBO(0, 128, 128, 1),
      side: BorderSide(
        color: Color.fromRGBO(0, 128, 128, 1),
        width: 2,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Color.fromRGBO(120, 176, 177, 1),
          width: 2,
        )),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.white,
  ),
  navigationRailTheme: NavigationRailThemeData(
    selectedLabelTextStyle: TextStyle(color: Colors.white),
    selectedIconTheme: IconThemeData(color: Colors.white),
  ),
);