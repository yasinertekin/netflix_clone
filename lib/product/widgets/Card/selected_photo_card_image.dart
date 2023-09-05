import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';

class SelectedPhotoCardImage extends StatelessWidget {
  const SelectedPhotoCardImage({
    super.key,
    required this.viewModel,
    this.photoURL,
  });

  final CreateSelectProfileViewModel viewModel;
  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';

    if (photoURL != null) {
      imageUrl = photoURL!;
    } else if (viewModel.newPhotoURL.isNotEmpty) {
      imageUrl = viewModel.newPhotoURL;
    } else {
      imageUrl = 'https://picsum.photos/200';
    }
    return SizedBox(
      height: context.dynamicHeight(0.2),
      child: Card(
        color: context.randomColor,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: context.dynamicHeight(0.2),
          width: context.dynamicWidth(0.32),
        ),
      ),
    );
  }
}
