import 'package:flutter/material.dart';

final myTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(
      Colors.white38,
    ),
    thumbVisibility: MaterialStateProperty.all(
      true,
    ),
    radius: const Radius.circular(8),
    thickness: MaterialStateProperty.all(
      3.0,
    ),
  ),
);
