import 'package:flutter/material.dart';

enum ImageConstants {
  netflixLogo('netflixlogo');

  final String value;
  // ignore: sort_constructors_first
  const ImageConstants(this.value);

  String get toPng => 'assets/images/logo/$value.png';
  Image get toImage => Image.asset(toPng);

  static const imagePath = "https://image.tmdb.org/t/p/w500";
}
