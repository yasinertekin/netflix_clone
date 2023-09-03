import 'package:flutter/material.dart';
import 'package:netflix_clone/product/theme/my_button_theme.dart';
import 'package:netflix_clone/product/theme/my_color_scheme.dart';
import 'package:netflix_clone/product/theme/my_input_decoration_theme.dart';

class AppTheme {
  const AppTheme(this.context);

  final BuildContext context;

  ThemeData get theme => ThemeData.dark().copyWith(
        colorScheme: MyColorScheme.darkColorScheme,
        brightness: Brightness.dark,
        outlinedButtonTheme: MyButtonTheme.outlinedButtonTheme,
        inputDecorationTheme: MyInputDecorationTheme.inputDecorationTheme,
      );
}
