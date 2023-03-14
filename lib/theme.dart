import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.indigo,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  // appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: Colors.indigo),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.indigo,
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  // appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: Colors.indigoAccent, foregroundColor: Colors.white),
);