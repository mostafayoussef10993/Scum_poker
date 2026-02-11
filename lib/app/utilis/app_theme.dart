import 'package:flutter/material.dart';

class LightBG {
  // Main Gradient Background for Light Mode
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 17, 39, 203), // Purple
      Color.fromARGB(255, 208, 212, 218), // Blue
      Color.fromARGB(255, 5, 139, 206), // Pink
      Color.fromARGB(255, 231, 235, 235), // Soft Orange
    ],
    stops: [0.0, 0.35, 0.7, 1.0],
  );

  static BoxDecoration backgroundDecoration = const BoxDecoration(
    gradient: backgroundGradient,
  );

  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
  );
}

class DarkBG {
  // Main Gradient Background for Dark Mode
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A1A2E), // Dark Blue
      Color(0xFF16213E), // Darker Blue
      Color(0xFF0F3460), // Deep Blue
      Color(0xFF533483), // Purple
    ],
    stops: [0.0, 0.35, 0.7, 1.0],
  );

  static BoxDecoration backgroundDecoration = const BoxDecoration(
    gradient: backgroundGradient,
  );

  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
  );
}

class ThemeBackground extends StatelessWidget {
  final Widget child;
  const ThemeBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    return Container(
      decoration: isLight
          ? LightBG.backgroundDecoration
          : DarkBG.backgroundDecoration,
      child: child,
    );
  }
}
