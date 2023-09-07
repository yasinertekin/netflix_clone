import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';

class AddProfiles extends StatefulWidget {
  const AddProfiles({super.key, required this.viewModel});

  final CreateSelectProfileViewModel viewModel;

  @override
  State<AddProfiles> createState() => _AddProfilesState();
}

class _AddProfilesState extends State<AddProfiles> {
  @override
  Widget build(BuildContext context) {
    return AddProfile(
      viewModel: widget.viewModel,
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
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ),
      ],
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
