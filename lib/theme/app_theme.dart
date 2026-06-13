import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme{
    static ThemeData lightTheme =ThemeData(
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.azul,
            foregroundColor: Colors.white,
            centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.azul,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
            ),
        ),
    );
}