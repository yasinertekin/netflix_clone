import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Profile/Add%20Profile/add_profile.dart';
import 'package:netflix_clone/feature/Profile/Add%20Profile/add_profile_bottom_sheet.dart';

mixin AddProfileMixin on State<AddProfiles> {
  void showAddProfileBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return AddProfileBottomSheet(
          viewModel: widget.viewModel,
        );
      },
    );
  }
}
