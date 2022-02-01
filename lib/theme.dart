import 'package:flutter/material.dart';

ThemeData appTheme() {
  ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: const TextTheme(
      subtitle2: TextStyle(
        fontFamily: 'Adanda',
        color: Color.fromARGB(255, 125, 125, 125),
        letterSpacing: -0.1,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Adanda',
        color: Color.fromARGB(255, 52, 52, 52),
        letterSpacing: -0.1,
      ),
    ),
  );
}
