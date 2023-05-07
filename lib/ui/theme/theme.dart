

import 'package:flutter/material.dart';
import 'package:stopwatch_dart/ui/theme/color.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
      primary: blue,
      surface: Colors.white,
      surfaceVariant: Colors.white70
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: lightBlue,
    onPrimary: Colors.white,
    surface: green,
    surfaceVariant: blue
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: blue,
  )
);