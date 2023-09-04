import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';

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
