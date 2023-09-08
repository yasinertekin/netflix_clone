import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/widgets/NetflixProgressIndicator/netflix_progress_indicator.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/edit_text_button.dart';

import '../Add Profile Bottom Sheet/add_profile.dart';

class CreateSelectProfileScreen extends StatelessWidget with MyNavigatorManager {
  const CreateSelectProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = CreateSelectProfileViewModel();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: _ProfileListAppBar(viewModel: viewModel),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: context.general.mediaQuery.size.height,
            width: context.general.mediaQuery.size.width,
            child: Observer(builder: (_) => _buildProfileContent(context, viewModel)),
          ),
        ),
      ),
    );
  }

  Column _buildProfileContent(BuildContext context, CreateSelectProfileViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileListView(context, viewModel),
      ],
    );
  }

  SizedBox _buildProfileListView(BuildContext context, CreateSelectProfileViewModel viewModel) {
    return SizedBox(
      height: context.dynamicHeight(1),
      child: _buildProfileFutureBuilder(viewModel),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> _buildProfileFutureBuilder(CreateSelectProfileViewModel viewModel) {
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
          return AddProfiles(viewModel: viewModel);
        } else {
          viewModel.profiles = snapshot.data!;
          return _buildGridForProfiles(viewModel);
        }
      },
    );
  }

  GridView _buildGridForProfiles(CreateSelectProfileViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: viewModel.profiles.length + 1, // Profil sayısı + 1 (Add düğmesi için)
      itemBuilder: (context, index) {
        return _generateProfileGridItems(index, viewModel, context);
      },
    );
  }

  Padding _generateProfileGridItems(int index, CreateSelectProfileViewModel viewModel, BuildContext context) {
    if (index == viewModel.profiles.isEmpty) {
      // Son eleman "Add" düğmesi
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AddProfiles(viewModel: viewModel),
      );
    } else if (index == viewModel.profiles.length) {
      // Son eleman "Add" düğmesi
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: viewModel.profiles.length < 5 && viewModel.isEdit
            ? const SizedBox.shrink()
            : AddProfiles(viewModel: viewModel),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildProfileCardWidget(context, viewModel, index),
      );
    }
  }

  Column _buildProfileCardWidget(BuildContext context, CreateSelectProfileViewModel viewModel, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(builder: (_) {
          return ProfileAvatarTile(isEditing: viewModel.isEdit, viewModel: viewModel, index: index);
        }),
        _profileUsername(viewModel, index),
      ],
    );
  }

  Text _profileUsername(
    CreateSelectProfileViewModel viewModel,
    int index,
  ) =>
      Text(viewModel.profiles[index]['username'] ?? '');
}

class _ProfileListAppBar extends StatelessWidget {
  const _ProfileListAppBar({
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

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
