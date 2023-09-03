import 'package:flutter/material.dart';

@immutable
class ColorConstants {
  const ColorConstants._();
  static const Color red = Color(0xFFe50915);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static Color get pink => Colors.pink.shade300;
  static const Color transparant = Colors.transparent;
  static const Color grey = Color(0xFF808080);
  static const Color dirtyPink = Color(0xff131313);
  static const Color carbon = Color(0xff333333);
}
