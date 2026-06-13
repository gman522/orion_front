import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme{
    static ThemeData lightTheme =ThemeData(
        scaffoldBackgroundColor: colors.white,

        appBarTheme: const appBarTheme(
            foregroundColor: AppColors.azul,
            foregroundColor: Colors.white,
            centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleForm(
                backgroundColor: AppColors.azul,
                foregroundColor: Colors.white,
                shape: RoundedRegtangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
            ),
        ),
    );
}