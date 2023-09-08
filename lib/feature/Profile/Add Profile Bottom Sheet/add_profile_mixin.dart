import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Profile/Add%20Profile%20Bottom%20Sheet/add_profile.dart';
import 'package:netflix_clone/feature/Profile/Add%20Profile%20Bottom%20Sheet/add_profile_bottom_sheet.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

mixin AddProfileMixin on State<AddProfile> {
  void showAddProfileBottomSheet() {
    showModalBottomSheet(
      backgroundColor: ColorConstants.black,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddProfileBottomSheet(
          viewModel: widget.viewModel,
        );
      },
    );
  }
}
