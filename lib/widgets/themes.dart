import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData LightTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        canvasColor: creamColor,
        primaryColor: darkOliveColor,
        scaffoldBackgroundColor: creamColor,
        appBarTheme: AppBarTheme(
          // backgroundColor: Colors.white,// actually we use transparent app bar so it is useless
          iconTheme: IconThemeData(color: darkOliveColor),
          elevation: 0.0,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: creamColor,
        ),
      );

  static ThemeData DarkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: darkCreamColor,
        canvasColor: Colors.black,
        primaryColor: oliveColor,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: oliveColor),
          elevation: 0.0,
        ),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
      );

  //colors
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkCreamColor = Color.fromARGB(255, 87, 87, 87);
  static Color oliveColor = Color.fromARGB(215, 105, 131, 61);
  static Color darkOliveColor = Color.fromARGB(237, 44, 65, 6);
}
