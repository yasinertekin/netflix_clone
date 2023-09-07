import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select%20Bottom%20Sheet/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _addProfileBodyBottomSheetHeader(context, viewModel: viewModel),
          Observer(builder: (_) {
            return SelectAvatarCards(
              viewModel: viewModel,
              photoURL: viewModel.newPhotoURL.isNotEmpty ? viewModel.newPhotoURL : null,
            );
          }),
          Padding(
            padding: context.padding.onlyTopLow,
            child: SizedBox(
              width: context.dynamicWidth(0.9),
              child: CustomTextFormField(viewModel: viewModel),
            ),
          ),
          const SwitchButton(),
        ],
      ),
    );
  }
}

Row _addProfileBodyBottomSheetHeader(BuildContext context, {required CreateSelectProfileViewModel viewModel}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const CancelTextButton(),
      Text(
        'Add Profile',
        style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      viewModel.newUsername.isNotEmpty && viewModel.newPhotoURL.isNotEmpty
          ? _saveButton(context, viewModel: viewModel)
          : const InactiveSaveButton(),
    ],
  );
}

TextButton _saveButton(BuildContext context, {required CreateSelectProfileViewModel viewModel}) {
  return TextButton(
    onPressed: () async {
      await viewModel.addProfile(
          viewModel.newUsername, viewModel.newPhotoURL); // Kullanıcı adını ve fotoğrafı burada kaydedin

      // ignore: use_build_context_synchronously
      context.navigation.pop();
    },
    child: Text(
      'Save',
      style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
