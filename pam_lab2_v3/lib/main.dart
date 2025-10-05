import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  runApp(const StreetClothesApp());
}

class StreetClothesApp extends StatelessWidget {
  const StreetClothesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Street Clothes',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
