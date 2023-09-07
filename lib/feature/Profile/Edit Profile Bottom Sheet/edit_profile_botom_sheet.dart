import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select%20Bottom%20Sheet/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_screen.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/int_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/models/ProfileBottomSheetModel/profile_bottom_sheet_model.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/cancel_text_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Field/custom_text_form_field.dart';

class EditBottomSheet extends StatelessWidget {
  const EditBottomSheet({
    super.key,
    required this.viewModel,
    required this.index,
  });
  final CreateSelectProfileViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.general.mediaQuery.size.height * IntConstants.defaultBottomSheetHeight,
      decoration: const BoxDecoration(
        color: ColorConstants.potBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DecorationConstants.defaultBorderRadius),
          topRight: Radius.circular(DecorationConstants.defaultBorderRadius),
        ),
      ),
      child: SingleChildScrollView(
        child: _EditProfileBottomSheetBody(viewModel: viewModel, index: index),
      ),
    );
  }
}

class _EditProfileBottomSheetBody extends StatelessWidget {
  const _EditProfileBottomSheetBody({
    required this.viewModel,
    required this.index,
  });

  final CreateSelectProfileViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EditProfileBottomSheetHeader(viewModel: viewModel, index: index),
        Observer(builder: (_) {
          return SelectAvatarCards(
            viewModel: viewModel,
            photoURL: viewModel.newPhotoURL.isEmpty ? viewModel.profiles[index]['photoURL'] : viewModel.newPhotoURL,
          );
        }),
        SizedBox(
          width: context.general.mediaQuery.size.width * IntConstants.defaultBottomSheetHeight,
          child: Observer(builder: (_) {
            return CustomTextFormField(
                viewModel: viewModel,
                titleText: viewModel.profiles[index]['username'] ?? StringConstans.profileUsername);
          }),
        ),
        const _EditProfileBottomSheetListModel()
      ],
    );
  }
}

class _EditProfileBottomSheetListModel extends StatelessWidget {
  const _EditProfileBottomSheetListModel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.general.mediaQuery.size.height * IntConstants.defaultBottomSheetHeight,
      child: ListView.builder(
          itemCount: ProfileBottomSheetModels.ProfileBottomSheetItems.length,
          itemBuilder: (context, index) {
            return _EditProfileBottomSheetCard(index);
          }),
    );
  }
}

// ignore: must_be_immutable
class _EditProfileBottomSheetCard extends StatelessWidget {
  _EditProfileBottomSheetCard(
    this.index,
  );

  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DecorationConstants.defaultBorderRadius),
        ),
        child: _CustomListTile(index: index),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ProfileBottomSheetModels.ProfileBottomSheetItems[index].title),
      leading: ProfileBottomSheetModels.ProfileBottomSheetItems[index].leading,
      subtitle: Text(ProfileBottomSheetModels.ProfileBottomSheetItems[index].subtitle),
      trailing: ProfileBottomSheetModels.ProfileBottomSheetItems[index].actions,
      titleAlignment: ListTileTitleAlignment.center,
    );
  }
}

class _EditProfileBottomSheetHeader extends StatelessWidget {
  const _EditProfileBottomSheetHeader({
    required this.viewModel,
    required this.index,
  });

  final CreateSelectProfileViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CancelTextButton(),
        const Text(StringConstans.editProfile),
        Observer(builder: (_) {
          return _CustomDoneButton(viewModel: viewModel, index: index);
        }),
      ],
    );
  }
}

class _CustomDoneButton extends StatelessWidget {
  const _CustomDoneButton({
    required this.viewModel,
    required this.index,
  });

  final CreateSelectProfileViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          _checkUsernameAndPhoto();
          viewModel.updateProfile(index, viewModel.newUsername,
              viewModel.newPhotoURL.isEmpty ? viewModel.profiles[index]['photoURL'] : viewModel.newPhotoURL);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateSelectProfileScreen()));
        },
        child: const Text(StringConstans.done));
  }

  void _checkUsernameAndPhoto() {
    if (viewModel.newUsername.isEmpty && viewModel.newPhotoURL.isEmpty) {
      viewModel.newUsername = viewModel.profiles[index]['username'] ?? '';
      viewModel.newPhotoURL = viewModel.profiles[index]['photoURL'] ?? '';
    }
  }
}
