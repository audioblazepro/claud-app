import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores principales de la aplicación
  static const Color primaryColor = Color(0xFF40C4FF); // Colors.lightBlue[300]
  static const Color backgroundColor = Colors.black;
  static const Color cardColor = Color(0xFF212121); // Colors.grey[900]
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFFBDBDBD); // Colors.grey[400]
  
  // Gradientes
  static const List<Color> primaryGradient = [
    Color(0xFF40C4FF),
    Color(0xFF0091EA),
  ];

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      
      // Configuración de texto
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),
      ),

      // Configuración de botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
      ),

      // Configuración de tarjetas
      cardTheme: CardTheme(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
      ),

      // Configuración de íconos
      iconTheme: const IconThemeData(
        color: primaryColor,
        size: 24,
      ),

      // Configuración de campos de texto
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        labelStyle: const TextStyle(color: secondaryTextColor),
        hintStyle: const TextStyle(color: secondaryTextColor),
      ),

      // Configuración de diálogos
      dialogTheme: DialogTheme(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        titleTextStyle: const TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Configuración de bottom navigation bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Configuración de floating action button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        elevation: 6,
      ),
    );
  }

  // Estilos de texto predefinidos
  static const TextStyle headlineStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: textColor,
  );

  // Decoraciones predefinidas
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );

  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: primaryGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(15),
  );
}