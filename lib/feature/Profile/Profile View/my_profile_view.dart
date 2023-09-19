// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Detail/detail_screen_bottom_sheet.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/My%20List%20Screen/my_list_screen.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';
import 'package:netflix_clone/product/widgets/Icon%20Button/search_icon_button.dart';
import 'package:netflix_clone/product/widgets/Icon%20Button/tv_icon_button.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({
    Key? key,
    required this.profileImage,
    required this.profileName,
  }) : super(key: key);

  final String? profileName;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.black,
        title: const Text(StringConstans.myNetflix),
        actions: [
          const TvIconButton(),
          SearchIconButton(
            cacheManager: homeViewModel.cacheManager,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Observer(builder: (_) {
                return _MyProfileHeader(
                  profileImage: profileImage,
                  profileName: profileName,
                );
              }),
              const _MyProfileLeadingsColumn(),
              const _MyListRow(),
              SizedBox(
                height: context.general.mediaQuery.size.height * 0.30,
                child: ListView.builder(
                  itemCount: homeViewModel.favoriteList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CardListPoster(
                      imagePath: homeViewModel.favoriteList[index].poster_path!,
                      mediaType: homeViewModel.favoriteList[index].media_type!,
                      index: index,
                      viewModel: homeViewModel,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MyListRow extends StatelessWidget {
  const _MyListRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: context.padding.onlyLeftLow,
          child: Text(
            StringConstans.mylist,
            style: context.general.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorConstants.white,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: ColorConstants.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyListScreen(),
              ),
            );
          },
          color: ColorConstants.white,
        ),
      ],
    );
  }
}

class _MyProfileLeadingsColumn extends StatelessWidget {
  const _MyProfileLeadingsColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _MyProfileLeading(
          ColorConstants.red,
          Icon(
            Icons.notifications,
            color: ColorConstants.white,
          ),
          StringConstans.notifications,
        ),
        _MyProfileLeading(
          ColorConstants.blue,
          Icon(
            Icons.download_sharp,
            color: ColorConstants.white,
          ),
          StringConstans.downloads,
        ),
      ],
    );
  }
}

class _MyProfileLeading extends StatelessWidget {
  const _MyProfileLeading(
    this.color,
    this.icon,
    this.title,
  ) : super();

  final Color color;
  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: icon,
          ),
          Padding(
            padding: context.padding.onlyLeftLow,
            child: Text(
              title,
              style: const TextStyle(color: ColorConstants.white),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: ColorConstants.white,
          ),
        ],
      ),
    );
  }
}

class _MyProfileHeader extends StatelessWidget {
  const _MyProfileHeader({
    required this.profileImage,
    required this.profileName,
  });

  final String? profileImage;
  final String? profileName;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return InkWell(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            context: context,
            builder: (context) {
              return SizedBox(
                height: context.general.mediaQuery.size.height * 0.30,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  elevation: 30,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: context.padding.low,
                            child: Text(
                              StringConstans.changProfile,
                              style: context.general.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(2),
                              shape: MaterialStateProperty.all(
                                const CircleBorder(),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.general.mediaQuery.size.height * 0.15,
                        child: ListView.builder(
                          itemCount: viewModel.profiles.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: context.general.mediaQuery.size.height * 0.10,
                                  width: context.general.mediaQuery.size.width * 0.20,
                                  child: ProfileAvatarTile(
                                    isEditing: viewModel.isEdit,
                                    index: index,
                                    profileModel: null,
                                  ),
                                ),
                                Text(
                                  viewModel.profiles[index]['username'],
                                  style: context.general.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Observer(builder: (_) {
                        return const _ProfileManagement();
                      })
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Column(
          children: [
            AvatarCard(
              photoURL: profileImage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  profileName!,
                  style: const TextStyle(color: ColorConstants.white),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: ColorConstants.white,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _ProfileManagement extends StatelessWidget {
  const _ProfileManagement();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: context.padding.onlyBottomLow,
        child: InkWell(
          onTap: () {
            viewModel.setIsEditing();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.edit),
              Text(
                StringConstans.profileManagement,
                style: context.general.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
