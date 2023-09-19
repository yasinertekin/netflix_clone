import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/widgets/NetflixProgressIndicator/netflix_progress_indicator.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/edit_text_button.dart';

import '../Add Profile Bottom Sheet/add_profile.dart';

class ProfileListScreen extends StatelessWidget with MyNavigatorManager {
  const ProfileListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _ProfileListAppBar(),
      ),
      backgroundColor: Colors.black,
      body: Observer(builder: (_) {
        return SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: context.general.mediaQuery.size.height,
              width: context.general.mediaQuery.size.width,
              child: _buildProfileContent(context),
            ),
          ),
        );
      }),
    );
  }

  Observer _buildProfileContent(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileListView(context),
        ],
      );
    });
  }

  SizedBox _buildProfileListView(BuildContext contex) {
    return SizedBox(
      height: contex.general.mediaQuery.size.height * 0.8,
      child: _buildProfileFutureBuilder(),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> _buildProfileFutureBuilder() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: viewModel.getProfiles(),
      builder: (context, snapshot) {
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
          return Observer(builder: (_) {
            return const AddProfiles();
          });
        } else {
          viewModel.profiles = snapshot.data!;
          return _buildGridForProfiles();
        }
      },
    );
  }

  GridView _buildGridForProfiles() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: viewModel.profiles.length + 1, // Profil sayısı + 1 (Add düğmesi için)
      itemBuilder: (context, index) {
        return _generateProfileGridItems(index, context);
      },
    );
  }

  Padding _generateProfileGridItems(int index, BuildContext context) {
    // ignore: unrelated_type_equality_checks
    if (index == viewModel.profiles.isEmpty) {
      // Son eleman "Add" düğmesi
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: AddProfiles(),
      );
    } else if (index == viewModel.profiles.length) {
      // Son eleman "Add" düğmesi
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: viewModel.profiles.length < 5 && viewModel.isEdit ? const SizedBox.shrink() : const AddProfiles(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildProfileCardWidget(context, index),
      );
    }
  }

  Column _buildProfileCardWidget(BuildContext context, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(builder: (_) {
          return ProfileAvatarTile(isEditing: viewModel.isEdit, index: index, profileModel: null);
        }),
        _profileUsername(index),
      ],
    );
  }

  Text _profileUsername(
    int index,
  ) =>
      Text(viewModel.profiles[index]['username'] ?? '');
}

class _ProfileListAppBar extends StatelessWidget {
  const _ProfileListAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text('Who is Watcing?'),
      actions: [
        Observer(builder: (_) {
          return EditTextButton(viewModel: viewModel);
        }),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
