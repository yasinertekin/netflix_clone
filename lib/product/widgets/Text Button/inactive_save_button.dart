import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InactiveSaveButton extends StatelessWidget {
  const InactiveSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: const Text(
        'Save',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
