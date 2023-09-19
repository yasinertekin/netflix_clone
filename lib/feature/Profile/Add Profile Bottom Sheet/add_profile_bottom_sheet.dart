import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select%20Bottom%20Sheet/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/profile_list.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/index.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';
import 'package:netflix_clone/product/widgets/Lottie/switch_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/cancel_text_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/inactive_save_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Field/custom_text_form_field.dart';

class AddProfileBottomSheet extends StatelessWidget with MyNavigatorManager {
  const AddProfileBottomSheet({
    super.key,
    required this.viewModel,
  });
  final CreateSelectProfileViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DecorationConstants.defaultBorderRadius),
          topRight: Radius.circular(DecorationConstants.defaultBorderRadius),
        ),
      ),
      height: context.general.mediaQuery.size.height * DoubleConstants.defaultBottomSheetHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _addProfileBodyBottomSheetHeader(context, viewModel: viewModel),
          Observer(builder: (_) {
            //Add profile de avatarın güncellenmesi için
            return SelectAvatarCards(
              viewModel: viewModel,
              photoURL: viewModel.selectedPhotoURL.isNotEmpty ? viewModel.selectedPhotoURL : null,
            );
          }),
          Padding(
            padding: context.padding.onlyTopLow,
            child: SizedBox(
              width: context.general.mediaQuery.size.width * DoubleConstants.defaultBottomSheetHeight,
              child: Observer(builder: (_) {
                return CustomTextFormField(viewModel: viewModel);
              }),
            ),
          ),
          const SwitchButton(),
        ],
      ),
    );
  }
}

Row _addProfileBodyBottomSheetHeader(
  BuildContext context, {
  required CreateSelectProfileViewModel viewModel,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const CancelTextButton(),
      Text(
        StringConstans.addProfile,
        style: context.general.textTheme.bodyLarge!.copyWith(
          color: ColorConstants.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      viewModel.selectedUsername.isNotEmpty && viewModel.selectedPhotoURL.isNotEmpty
          ? Observer(
              builder: (_) => TextButton(
                onPressed: () async {
                  await viewModel.addProfile(
                    ProfileModel(
                      username: viewModel.selectedUsername,
                      photoURL: viewModel.selectedPhotoURL,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileListScreen()),
                  );
                },
                child: Text(
                  StringConstans.save,
                  style: context.general.textTheme.bodyLarge!.copyWith(
                    color: ColorConstants.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : const InactiveSaveButton(),
    ],
  );
}
