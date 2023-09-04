import 'package:flutter/material.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 0,
      right: -1,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
