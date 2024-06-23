// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This is our  main focus
// Let's apply dark and dark theme on our app
// Now let's add dark theme on our appimport 'package:flutter/material.dart';

const kPrimaryColor = Color(0XFF4286f4);
// const kPrimaryColor = Color.fromARGB(255, 226, 111, 146);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color.fromARGB(255, 0, 0, 0);
const kContentColorDarkTheme = Color.fromARGB(255, 237, 241, 239);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);
const kback = Colors.white;
const kDefaultPadding = 20.0;
ThemeData lightThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
        )),
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.quicksandTextTheme(
      Theme.of(context).textTheme,
    ).apply(
      bodyColor: kContentColorLightTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    useMaterial3: false,
    primaryColorLight: kPrimaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kback,
      selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kContentColorLightTheme),
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    useMaterial3: false,
    hoverColor: kPrimaryColor.withOpacity(0.4),
    highlightColor: kPrimaryColor.withOpacity(0.4),
    focusColor: kPrimaryColor.withOpacity(0.4),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(141, 4, 13, 42),
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
