import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile_botom_sheet.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

mixin EditProfileMixin on State<ProfileAvatarTile> {
  late final CreateSelectProfileViewModel viewModel;

  void showEditProfileSheet(BuildContext context, int index, CreateSelectProfileViewModel viewModel) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ColorConstants.black,
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
