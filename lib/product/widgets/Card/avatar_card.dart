// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

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
            photos != null && photoIndex != null ? photos![photoIndex!] : photoURL!,
            height: context.dynamicHeight(0.20),
            width: context.dynamicWidth(0.32),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
