import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Avatar%20Select/avatar_select.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/feature/TabBar/tab_bar_screen.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/models/ProfileBottomSheetModel/index.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/cancel_text_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/edit_text_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Field/custom_text_form_field.dart';

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
              height: MediaQuery.of(context).size.height,
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

  Text _profileUsername(
    CreateSelectProfileViewModel viewModel,
    int index,
  ) =>
      Text(viewModel.profiles[index]['username'] ?? '');

  InkWell _profileAvatarTile(BuildContext context, CreateSelectProfileViewModel viewModel, int index) {
    return InkWell(
      onTap: () {
        viewModel.isEditing
            ? showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.black,
                context: context,
                builder: (context) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: const BoxDecoration(
                        color: Color(0xff161616),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CancelTextButton(),
                                const Text('Edit Profile'),
                                Observer(builder: (_) {
                                  return TextButton(
                                      onPressed: () {
                                        if (viewModel.newUsername.isEmpty && viewModel.newPhotoURL.isEmpty) {
                                          viewModel.newUsername = viewModel.profiles[index]['username'] ?? '';
                                          viewModel.newPhotoURL = viewModel.profiles[index]['photoURL'] ?? '';
                                        }
                                        viewModel.updateProfile(
                                            index,
                                            viewModel.newUsername,
                                            viewModel.newPhotoURL.isEmpty
                                                ? viewModel.profiles[index]['photoURL']
                                                : viewModel.newPhotoURL);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => const CreateSelectProfileScreen()));
                                      },
                                      child: const Text('Done'));
                                }),
                              ],
                            ),
                            Observer(
                              builder: (_) {
                                return SelectAvatarCardS(
                                  viewModel: viewModel,
                                  photoURL: viewModel.newPhotoURL.isEmpty
                                      ? viewModel.profiles[index]['photoURL']
                                      : viewModel.newPhotoURL,
                                );
                              },
                            ),
                            SizedBox(
                              width: context.dynamicWidth(0.8),
                              child: CustomTextFormField(
                                  viewModel: viewModel,
                                  titleText: viewModel.profiles[index]['username'] ?? 'Profile Username'),
                            ),
                            SizedBox(
                              height: context.dynamicHeight(0.7),
                              child: ListView.builder(
                                  itemCount: ProfileBottomSheetModels.ProfileBottomSheetItems.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: context.padding.low,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          title: Text(ProfileBottomSheetModels.ProfileBottomSheetItems[index].title),
                                          leading: ProfileBottomSheetModels.ProfileBottomSheetItems[index].leading,
                                          subtitle:
                                              Text(ProfileBottomSheetModels.ProfileBottomSheetItems[index].subtitle),
                                          trailing: ProfileBottomSheetModels.ProfileBottomSheetItems[index].actions,
                                          titleAlignment: ListTileTitleAlignment.center,
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ));
                },
              )
            : navigatoToWidget(
                context,
                TabBarScreen(
                  profileImage: viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
                  profileName: viewModel.profiles[index]['username'] ?? '',
                ),
              );
      },
      child: Observer(
        builder: (_) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AvatarCard(
                isEditing: viewModel.isEditing,
                photoURL: viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
              ),
              viewModel.isEditing
                  ? const Card(
                      color: Colors.transparent,
                      elevation: 45,
                      child: Icon(
                        Icons.edit,
                        size: 40,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          );
        },
      ),
    );
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
      actions: [EditTextButton(viewModel: viewModel)],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

/* child: ListTile(
                                          title: Text(ProfileBottomSheetModels.ProfileBottomSheetItems[index].title),
                                          leading: ProfileBottomSheetModels.ProfileBottomSheetItems[index].leading,
                                          subtitle:
                                              Text(ProfileBottomSheetModels.ProfileBottomSheetItems[index].subtitle),
                                          trailing: ProfileBottomSheetModels.ProfileBottomSheetItems[index].actions,
                                          titleAlignment: ListTileTitleAlignment.center,
                                        ),*/
