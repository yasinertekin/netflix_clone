import 'package:flutter/material.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

class MyInputDecorationTheme {
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorConstants.transparant,
        width: 0,
      ),
    ),
    fillColor: ColorConstants.carbon,
    labelStyle: const TextStyle(color: ColorConstants.grey),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    activeIndicatorBorder: const BorderSide(
      style: BorderStyle.solid,
      width: 2,
      color: ColorConstants.dirtyPink,
    ),
  );
}
