import "package:flutter/material.dart";

final fanTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "EB Garamond",
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 24),
      bodyLarge: TextStyle(fontSize: 28),
      displaySmall: TextStyle(fontSize: 32),
      displayMedium: TextStyle(fontSize: 36),
      displayLarge: TextStyle(fontSize: 40),
      headlineSmall: TextStyle(fontSize: 44),
      headlineMedium: TextStyle(fontSize: 48),
      headlineLarge: TextStyle(fontSize: 52),
      titleSmall: TextStyle(fontSize: 56),
      titleMedium: TextStyle(fontSize: 60),
      titleLarge: TextStyle(fontSize: 64),
      labelSmall: TextStyle(fontSize: 68),
      labelMedium: TextStyle(fontSize: 72),
      labelLarge: TextStyle(fontSize: 76),
    ));

final theme = ThemeData(
    fontFamily: "EB Garamond",
    textTheme: const TextTheme(
      // Small
      bodySmall: TextStyle(fontSize: 20),
      displaySmall: TextStyle(fontSize: 20),
      headlineSmall: TextStyle(fontSize: 26),
      titleSmall: TextStyle(fontSize: 26),
      labelSmall: TextStyle(fontSize: 24),
      // Medium
      bodyMedium: TextStyle(fontSize: 24),
      displayMedium: TextStyle(fontSize: 24),
      headlineMedium: TextStyle(fontSize: 30),
      titleMedium: TextStyle(fontSize: 30),
      labelMedium: TextStyle(fontSize: 28),
      // Large
      bodyLarge: TextStyle(fontSize: 28),
      displayLarge: TextStyle(fontSize: 28),
      headlineLarge: TextStyle(fontSize: 34),
      titleLarge: TextStyle(fontSize: 34),
      labelLarge: TextStyle(fontSize: 32),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 20),
    ));
