import 'package:flutter/material.dart';
import 'package:netflix_clone/product/widgets/Lottie/switch_button.dart';

class ProfileBottomSheetModel {
  final String title;
  final String subtitle;
  final Icon leading;
  final Widget actions;

  ProfileBottomSheetModel(this.title, this.subtitle, this.leading, this.actions);
}

class ProfileBottomSheetModels {
  static final List<ProfileBottomSheetModel> ProfileBottomSheetItems = [
    ProfileBottomSheetModel(
      'maturity level',
      'no restrictions',
      const Icon(Icons.warning),
      const Icon(Icons.arrow_forward_ios_rounded),
    ),
    ProfileBottomSheetModel(
      'Display Language',
      'English',
      const Icon(Icons.translate),
      const Icon(Icons.arrow_forward_ios_rounded),
    ),
    ProfileBottomSheetModel(
      'Voice and Subtitle',
      'no restrictions',
      const Icon(Icons.subtitles),
      const Icon(Icons.arrow_forward_ios_rounded),
    ),
    ProfileBottomSheetModel(
      'Autoplay next episode',
      '',
      const Icon(Icons.play_circle_outline_rounded),
      const SwitchButton(),
    ),
    ProfileBottomSheetModel('maturity level', 'no restrictions', const Icon(Icons.replay), const SwitchButton()),
  ];
}
