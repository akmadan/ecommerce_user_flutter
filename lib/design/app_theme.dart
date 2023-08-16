import 'package:flutter/material.dart';

class AppTheme{ 
  static ThemeData lighThemeData = ThemeData(
    primaryColor: Colors.teal, 
    appBarTheme:const AppBarTheme(color: Colors.teal),
    brightness: Brightness.light, 
    
    elevatedButtonTheme:ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.teal)
      )
    )

  );
}