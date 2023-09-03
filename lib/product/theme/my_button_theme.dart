import 'package:flutter/material.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

class MyButtonTheme {
  static final OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(
        ColorConstants.transparant,
      ),
      foregroundColor: MaterialStateProperty.all(ColorConstants.white),
      side: MaterialStateProperty.all(
        const BorderSide(
          color: ColorConstants.black,
          width: 1,
        ),
      ),
      elevation: MaterialStateProperty.all(1),
      backgroundColor: MaterialStateProperty.all(
        ColorConstants.dirtyPink,
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: ColorConstants.transparant,
          ),
        ),
      ),
    ),
  );
}
