import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();
  
  // Light theme colors
  static const Color _lightPrimaryColor = Color(0xFF2E7D32);
  static const Color _lightSecondaryColor = Color(0xFFFFC107);
  static const Color _lightBackgroundColor = Color(0xFFE8F5E9);
  static const Color _lightSurfaceColor = Color(0xFFFFFFFF);
  
  // Dark theme colors
  static const Color _darkPrimaryColor = Color(0xFF4CAF50);
  static const Color _darkSecondaryColor = Color(0xFFFFD54F);
  static const Color _darkSurfaceColor = Color(0xFF1E1E1E);
  
  // Shared colors
  static const Color _errorColor = Color(0xFFB00020);
  
  // Game colors
  static Color snakeHeadColor = Colors.green.shade400;
  static Color snakeBodyColor = Colors.green.shade600;
  static Color foodColor = Colors.red.shade600;
  static Color obstacleColor = Colors.brown.shade800;
  
  // Gradient presets
  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.green.shade700,
      Colors.green.shade900,
    ],
  );
  
  static LinearGradient gameBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.green.shade900,
      Colors.green.shade700,
      Colors.black,
    ],
    stops: const [0.0, 0.6, 1.0],
  );
  
  static LinearGradient gameOverGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.red.shade900,
      Colors.red.shade800,
      Colors.black,
    ],
    stops: const [0.0, 0.6, 1.0],
  );
  
  // Light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      surface: _lightSurfaceColor,
      surfaceContainerHighest: _lightBackgroundColor,
      error: _errorColor,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: GoogleFonts.poppinsTextTheme(),
    buttonTheme: const ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
  );
  
  // Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      surface: _darkSurfaceColor,
      error: _errorColor,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    buttonTheme: const ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade600,
        elevation: 10,
        shadowColor: Colors.black.withAlpha((0.7 * 255).toInt()),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.green.shade300.withAlpha((0.4 * 255).toInt())),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withAlpha((0.6 * 255).toInt()),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade800,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
  );
  
  // Game-specific theme
  static ThemeData gameTheme = darkTheme.copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green.shade900,
      elevation: 8,
      centerTitle: true,
      shadowColor: Colors.black.withAlpha((0.6 * 255).toInt()),
      titleTextStyle: GoogleFonts.rubik(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ),
  );
}
