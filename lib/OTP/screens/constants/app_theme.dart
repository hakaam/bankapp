import 'package:flutter/material.dart';
import 'constants.dart';

// LightTheme
ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.grey,
    textTheme: textTheme(),
    primaryColor: primaryColor,
    elevatedButtonTheme: elevateButtom(),
  );
}

// Text Theme
TextTheme textTheme() {
  return const TextTheme(
    headline2: bodysmall2,
    bodyText1: bodyText1,
    bodyText2: bodyText2,
    headline1: headline,
  );
}

// ElevatedButton Theme
ElevatedButtonThemeData elevateButtom() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: lightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      minimumSize: const Size(double.infinity, 40),
      elevation: 0,
    ),
  );
}
