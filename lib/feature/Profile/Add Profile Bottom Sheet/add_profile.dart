import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Add%20Profile%20Bottom%20Sheet/add_profile_mixin.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/index.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';

class AddProfiles extends StatelessWidget {
  const AddProfiles({super.key, required this.viewModel});

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SizedBox(
        child: AddProfile(
          viewModel: viewModel,
        ),
      );
    });
  }
}

class AddProfile extends StatefulWidget with MyNavigatorManager {
  const AddProfile({
    super.key,
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> with AddProfileMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAddProfileBottomSheet();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _addProfileCard(context),
          Padding(
            padding: context.padding.onlyBottomLow,
            child: const _AddProfileText(),
          ),
        ],
      ),
    );
  }

  Card _addProfileCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(DecorationConstants.lowBorderRadius)),
        side: BorderSide(color: ColorConstants.grey, width: 1),
      ),
      color: ColorConstants.transparant,
      child: _addProfileBody(context),
    );
  }

  Column _addProfileBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: context.general.mediaQuery.size.height * DoubleConstants.defaultAvatarCardHeight,
            width: context.general.mediaQuery.size.width * DoubleConstants.defaultAvatarCardWidth,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            )),
      ],
    );
  }
}

class _AddProfileText extends StatelessWidget {
  const _AddProfileText();

  @override
  Widget build(BuildContext context) {
    return Text(
      StringConstans.addProfile,
      style: context.general.textTheme.bodyLarge?.copyWith(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
