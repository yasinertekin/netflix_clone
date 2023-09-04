import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/feature/TabBar/tab_bar_screen.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';

import '../Add Profile/add_profile.dart';

class CreateSelectProfileScreen extends StatelessWidget with MyNavigatorManager {
  const CreateSelectProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = CreateSelectProfileViewModel();
    return Observer(builder: (_) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _ProfileListAppBar(viewModel: viewModel),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: context.dynamicHeight(1),
              width: context.dynamicWidth(1),
              child: Observer(builder: (_) => _buildProfileContent(context, viewModel)),
            ),
          ),
        ),
      );
    });
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
          return const CircularProgressIndicator();
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
        child: viewModel.profiles.length < 5 ? AddProfiles(viewModel: viewModel) : const SizedBox.shrink(),
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
        _profileAvatarTile(context, viewModel, index),
        _profileUsername(viewModel, index),
      ],
    );
  }

  Text _profileUsername(CreateSelectProfileViewModel viewModel, int index) =>
      Text(viewModel.profiles[index]['username'] ?? '');

  InkWell _profileAvatarTile(BuildContext context, CreateSelectProfileViewModel viewModel, int index) {
    return InkWell(onTap: () {
      viewModel.isEditing
          ? navigatoToWidget(
              context,
              TabBarScreen(
                initialTabIndex: 2,
                profileImage: viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
                profileName: viewModel.profiles[index]['username'] ?? '',
              ),
            )
          : navigatoToWidget(
              context,
              TabBarScreen(
                profileImage: viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
                profileName: viewModel.profiles[index]['username'] ?? '',
              ),
            );
    }, child: Observer(builder: (_) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Card(
            color: context.randomColor,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(viewModel.isEditing ? Colors.black : Colors.transparent, BlendMode.color),
                child: Image.network(
                  viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
                  height: context.dynamicHeight(0.20),
                  width: context.dynamicWidth(0.32),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          viewModel.isEditing
              ? const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                )
              : const SizedBox.shrink()
        ],
      );
    }));
  }
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
      actions: [_EditTextButton(viewModel: viewModel)],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

class _EditTextButton extends StatelessWidget {
  const _EditTextButton({
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
        child: viewModel.isEditing
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
