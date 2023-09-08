import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';

class EditTextButton extends StatelessWidget {
  const EditTextButton({
    super.key,
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TextButton(
        onPressed: () {
          viewModel.setIsEditing();
        },
        child: viewModel.isEdit
            ? const Text(
                'Done',
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                'Edit',
                style: TextStyle(color: Colors.white),
              ),
      );
    });
  }
}
