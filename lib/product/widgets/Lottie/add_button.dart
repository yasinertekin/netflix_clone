import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Lottie.asset(
        alignment: Alignment.center,
        fit: BoxFit.contain,
        'assets/lottie/checkBoxLottie.json',
        height: 100,
        reverse: true,
        width: 100,
      ),
    );
  }
}
