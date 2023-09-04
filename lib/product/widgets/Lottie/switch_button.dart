import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      repeat: false,
      'assets/lottie/tswitch.json',
      height: context.dynamicHeight(0.1),
      width: context.dynamicWidth(0.1),
    );
  }
}
