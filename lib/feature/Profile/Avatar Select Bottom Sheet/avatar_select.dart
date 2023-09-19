// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select%20Bottom%20Sheet/avatar_select_mixin.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';
import 'package:netflix_clone/product/widgets/Icon%20Button/edit_icon_button.dart';

class SelectAvatarCards extends StatelessWidget {
  const SelectAvatarCards({super.key, required this.viewModel, this.photoURL});
  final CreateSelectProfileViewModel viewModel;
  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SelectAvatarCard(viewModel: viewModel, photoURL: photoURL)],
    );
  }
}

class SelectAvatarCard extends StatefulWidget {
  const SelectAvatarCard({
    super.key,
    required this.viewModel,
    this.photoURL,
  });

  final CreateSelectProfileViewModel viewModel;
  final String? photoURL;

  @override
  State<SelectAvatarCard> createState() => _SelectAvatarCardState();
}

class _SelectAvatarCardState extends State<SelectAvatarCard> with AvatarSelectMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAvatarSelectSheet(context, widget.viewModel);
      },
      child: Stack(
        children: [
          AvatarCard(
            photoURL: widget.photoURL,
          ),
          const EditIconButton(),
        ],
      ),
    );
  }
}
