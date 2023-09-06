import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_screen.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/widgets/Lottie/switch_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/cancel_text_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/inactive_save_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Field/custom_text_form_field.dart';

class AddProfiles extends StatelessWidget {
  const AddProfiles({super.key, required this.viewModel});

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return AddProfile(
      viewModel: viewModel,
    );
  }
}

class AddProfile extends StatelessWidget with MyNavigatorManager {
  const AddProfile({
    super.key,
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _addProfileCard(context),
        Padding(
          padding: context.padding.onlyBottomLow,
          child: const _AddProfileText(),
        ),
      ],
    );
  }

  Card _addProfileCard(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      color: Colors.transparent,
      child: _addProfileBody(context),
    );
  }

  Column _addProfileBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.20),
          width: context.dynamicWidth(0.32),
          child: IconButton(
            iconSize: 45,
            onPressed: () {
              _addProfileBodyBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _addProfileBodyBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _addProfileBodyBottomSheetHeader(context),
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
      },
    );
  }

  Row _addProfileBodyBottomSheetHeader(BuildContext context) {
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
            ? _saveButton(context)
            : const InactiveSaveButton(),
      ],
    );
  }

  TextButton _saveButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await viewModel.addProfile(
            viewModel.newUsername, viewModel.newPhotoURL); // Kullanıcı adını ve fotoğrafı burada kaydedin

        // ignore: use_build_context_synchronously
        navigatoToWidget(
          context,
          const CreateSelectProfileScreen(),
        );
      },
      child: Text(
        'Save',
        style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _AddProfileText extends StatelessWidget {
  const _AddProfileText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add Profile',
      style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
