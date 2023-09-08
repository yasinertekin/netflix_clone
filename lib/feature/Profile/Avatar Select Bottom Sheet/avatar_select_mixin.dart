import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select%20Bottom%20Sheet/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select%20Bottom%20Sheet/avatar_select_bottom_sheet.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/widgets/NetflixProgressIndicator/netflix_progress_indicator.dart';

mixin AvatarSelectMixin on State<SelectAvatarCard> {
  void showAvatarSelectSheet(BuildContext context, CreateSelectProfileViewModel viewModel) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: viewModel.getCharacterDataList(),
          builder: (context, snapshot) {
            return _dataControl(snapshot, viewModel);
          },
        );
      },
    );
  }
}
Widget _dataControl(AsyncSnapshot<List<Map<String, dynamic>>> snapshot, CreateSelectProfileViewModel viewModel) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const NetflixProgressIndicator(
      strokeWidth: 6.0, // İlerleme çizgisinin kalınlığı
      radius: 25.0, // İlerleme çizgisinin yarı çapı
      backgroundColor: Colors.grey, // Arkaplan rengi
      progressColor: Colors.red, // İlerleme rengi
    );
  } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return const Text('No characters available.');
  } else {
    return AvatarSelectBottomSheet(
      viewModel: viewModel,
      snapshot: snapshot,
    );
  }
}
