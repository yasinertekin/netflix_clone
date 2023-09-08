// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';

class AvatarCard extends StatelessWidget {
  final bool? isEditing;
  final String? photoURL;
  final List? photos;
  int? photoIndex;

  AvatarCard({
    Key? key,
    this.photos,
    this.isEditing,
    this.photoIndex,
    this.photoURL,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewModel = CreateSelectProfileViewModel();
    String avatar;
    if (viewModel.selectedPhotoURL.isNotEmpty) {
      avatar = viewModel.selectedPhotoURL;
    } else if (viewModel.selectedPhotoURL.isEmpty && photoURL == null) {
      avatar = photos != null && photoIndex != null ? photos![photoIndex!] : 'https://picsum.photos/200/300';
    } else {
      avatar = photos != null && photoIndex != null ? photos![photoIndex!] : photoURL!;
    }
    return Card(
      color: context.randomColor,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ColorFiltered(
          colorFilter:
              ColorFilter.mode(isEditing != null && isEditing! ? Colors.black : Colors.transparent, BlendMode.color),
          child: Image.network(
            avatar,
            height: context.dynamicHeight(0.20),
            width: context.dynamicWidth(0.32),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
