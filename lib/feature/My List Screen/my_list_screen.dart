// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Home/HomeScreenAppBar/home_screen_app_bar.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/My%20List%20Screen/my_list_screen_mixin.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/feature/Search/search_view.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key, this.viewModel});

  final CreateSelectProfileViewModel? viewModel;

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> with TickerProviderStateMixin, MyListScreenMixin {
  @override
  Widget build(BuildContext context) {
    const double paddingHigh = 50;
    CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');

    return DefaultTabController(
      length: 2,
      child: Observer(
        builder: (_) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(context.general.mediaQuery.size.height * 0.1),
              child: const _MyListScreenAppBar(paddingHigh: paddingHigh)),
          body: StreamBuilder<DocumentSnapshot>(
            stream: profiles
                .doc(
                  FirebaseAuth.instance.currentUser!.uid,
                )
                .snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${StringConstans.somethingWentWrong} ${snapshot.error}',
                    );
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text('${StringConstans.dataNotFound}}');
                  }
                  // Firestore'dan verileri alma işlemi
                  Map<String, dynamic>? profileData = snapshot.data?.data() as Map<String, dynamic>?;

                  if (profileData == null || !profileData.containsKey('favoriteMovies')) {
                    return const Text('${StringConstans.dataNotFound}}');
                  }

                  List<dynamic> favoriteMoviesData = profileData['favoriteMovies'];

                  parseMovies(favoriteMoviesData);

                  return _favoriteListBody();
              }
            },
          ),
        ),
      ),
    );
  }

  Observer _favoriteListBody() {
    return Observer(
      builder: (context) => TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              HomeAppBarBottom(
                viewModel: homeViewModel,
              ),
              _favoriteList(),
            ],
          ),
          const Center(
            child: Text(StringConstans.games),
          ),
        ],
      ),
    );
  }

  Expanded _favoriteList() {
    return Expanded(
      child: SizedBox(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            return natificationListener(notification);
          },
          child: Observer(builder: (_) {
            return _favoriteListBuilder();
          }),
        ),
      ),
    );
  }

  ListView _favoriteListBuilder() {
    return ListView.builder(
      itemCount: homeViewModel.favoriteList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.padding.low,
          child: InkWell(
            onTap: () {
              showDetailScreenBottomSheet(index);
            },
            child: _cardDismissible(context, index),
          ),
        );
      },
    );
  }

  Dismissible _cardDismissible(BuildContext context, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            DecorationConstants.defaultBorderRadius,
          ),
          color: ColorConstants.red,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: DecorationConstants.defaultBorderRadius,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: ColorConstants.white,
          size: 30,
        ),
      ),
      confirmDismiss: (direction) async {
        var result = await showConfirmDialog(context);

        if (result == true) {
          return true;
        }

        return false;
      },
      movementDuration: context.duration.durationLow,
      onDismissed: (direction) {
        viewModel.removeFavoriteMovie(
          FirebaseAuth.instance.currentUser!.uid,
          homeViewModel.favoriteList[index],
        );
      },
      child: BackdropCard(
        backdrop_path: homeViewModel.favoriteList[index].backdrop_path!,
        name: homeViewModel.favoriteList[index].title ?? homeViewModel.favoriteList[index].name!,
        index: index,
      ),
    );
  }
}

class _MyListScreenAppBar extends StatelessWidget {
  const _MyListScreenAppBar({
    required this.paddingHigh,
  });

  final double paddingHigh;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(StringConstans.mylist),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
      ],
      backgroundColor: ColorConstants.black,
      bottom: TabBar(
        indicatorPadding: EdgeInsets.only(
          left: paddingHigh,
          right: paddingHigh,
          bottom: paddingHigh,
        ),
        indicatorColor: ColorConstants.red,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 5,
        tabs: const [
          Tab(
            text: StringConstans.moviesAndTvShows,
          ),
          Tab(
            text: StringConstans.games,
          ),
        ],
      ),
    );
  }
}
