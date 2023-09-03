import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';

class SupportTextButton extends StatelessWidget {
  const SupportTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        StringConstans.support,
        style: context.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
