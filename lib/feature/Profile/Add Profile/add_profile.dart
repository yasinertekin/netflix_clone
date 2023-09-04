import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_screen.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';

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
              SelectAvatarCardS(viewModel: viewModel),
              Padding(
                padding: context.padding.onlyTopLow,
                child: SizedBox(
                  width: context.dynamicWidth(0.9),
                  child: _CustomTextFormField(viewModel: viewModel),
                ),
              ),
              Lottie.asset(
                repeat: false,
                'assets/lottie/tswitch.json',
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(0.1),
              ),
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
        const _CancelTextButton(),
        Text(
          'Add Profile    ',
          style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        viewModel.newUsername.isNotEmpty && viewModel.newPhotoURL.isNotEmpty
            ? _saveButton(context)
            : const _InactiveSaveButton(),
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

class _CustomTextFormField extends StatelessWidget {
  const _CustomTextFormField({
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        viewModel.newUsername = value;
      },
      style: context.general.textTheme.bodyLarge!.copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Profile Name',
        hintStyle: context.general.textTheme.bodyLarge!.copyWith(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

class _CancelTextButton extends StatelessWidget {
  const _CancelTextButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _InactiveSaveButton extends StatelessWidget {
  const _InactiveSaveButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: const Text(
        'Save',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class SelectedPhotoCardImage extends StatelessWidget {
  const SelectedPhotoCardImage({
    super.key,
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.2),
      child: Card(
        color: context.randomColor,
        child: Image.network(
          viewModel.newPhotoURL.isNotEmpty ? viewModel.newPhotoURL : 'https://picsum.photos/200',
          fit: BoxFit.cover,
          height: context.dynamicHeight(0.2),
          width: context.dynamicWidth(0.32),
        ),
      ),
    );
  }
}

class EditIconButton extends StatelessWidget {
  const EditIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 0,
      right: -1,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
