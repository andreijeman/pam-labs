import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Montserrat',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.grey),
  ),
);
