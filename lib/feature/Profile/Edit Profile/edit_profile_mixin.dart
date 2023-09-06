import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile/edit_profile.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile/edit_profile_botom_sheet.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';

mixin EditProfileMixin on State<ProfileAvatarTile> {
  late final CreateSelectProfileViewModel viewModel;

  void showEditProfileSheet(BuildContext context, int index, CreateSelectProfileViewModel viewModel) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        return EditBottomSheet(
          viewModel: viewModel,
          index: index,
        );
      },
    );
  }
}
