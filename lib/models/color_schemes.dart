import 'package:flutter/material.dart';

Color primLight = Color.fromARGB(255, 136, 114, 99);
Color secLight = const Color.fromARGB(255, 236, 220, 204);

Color primDark = Color.fromARGB(255, 99, 86, 76);
Color secDark = Color.fromARGB(255, 189, 180, 172);

Color backDark = Color.fromARGB(255, 36, 35, 35);

ColorScheme lightMode = ColorScheme(
    brightness: Brightness.light,
    background: const Color.fromARGB(255, 255, 255, 255),
    onBackground: backDark,
    surface: const Color.fromARGB(255, 255, 255, 255),
    onSurface: backDark,
    primary: primLight,
    secondary: secLight,
    onPrimary: secLight,
    onSecondary: primLight,
    error: const Color.fromARGB(255, 204, 0, 0),
    onError: const Color.fromARGB(255, 255, 255, 255));

ColorScheme darkMode = ColorScheme(
    brightness: Brightness.dark,
    background: backDark,
    onBackground: secLight,
    surface: backDark,
    onSurface: secLight,
    primary: primDark,
    secondary: secDark,
    onPrimary: secDark,
    onSecondary: primDark,
    error: const Color.fromARGB(255, 204, 0, 0),
    onError: const Color.fromARGB(255, 255, 255, 255));

TextTheme lightText =
    const TextTheme().apply(bodyColor: backDark, displayColor: backDark);

TextTheme darkText =
    const TextTheme().apply(bodyColor: secLight, displayColor: secLight);

ButtonThemeData buttonLight =
    ButtonThemeData(buttonColor: primLight, textTheme: ButtonTextTheme.primary);

ButtonThemeData buttonDark =
    ButtonThemeData(buttonColor: primDark, textTheme: ButtonTextTheme.primary);
