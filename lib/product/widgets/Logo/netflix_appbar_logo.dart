import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../enums/image_enums.dart';

class NetflixAppBarLogo extends StatelessWidget {
  const NetflixAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageConstants.netflixLogo.toPng,
      fit: BoxFit.cover,
      height: context.dynamicHeight(0.1),
    );
  }
}
