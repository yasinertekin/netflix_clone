import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/Profile/Profile%20View/my_profile_view.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/enums/tab_bar_enums.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';

// ignore: must_be_immutable
class TabBarScreen extends StatefulWidget {
  TabBarScreen(
      {super.key,
      this.profileName,
      this.profileImage,
      this.initialTabIndex = 0,
      required this.profileViewModel,
      required this.profileModel});

  String? profileName;
  String? profileImage;
  final int initialTabIndex;
  final ProfileModel? profileModel;

  final CreateSelectProfileViewModel profileViewModel;

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: MyTabviews.values.length,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyTabviews.values.length,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          color: ColorConstants.black,
          child: myTabView(),
        ),
        body: _TabBarView(
          tabController: _tabController,
          profileName: widget.profileName,
          profileViewModel: widget.profileViewModel,
          profileModel: widget.profileModel,
          profileImage: widget.profileImage,
        ),
      ),
    );
  }

  myTabView() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: ColorConstants.black,
      dividerColor: ColorConstants.transparant,
      indicatorWeight: 3,
      tabAlignment: TabAlignment.fill,
      //isScrollable: true,
      labelColor: ColorConstants.white,
      unselectedLabelColor: ColorConstants.grey,
      controller: _tabController,
      tabs: MyTabViewsValuesMap().toList(),
    );
  }

  Iterable<Tab> MyTabViewsValuesMap() {
    const double iconSize = 20;

    return MyTabviews.values.map(
      (e) {
        if (e.name == 'home') {
          return Tab(
            text: e.name,
            icon: const Icon(Icons.home, size: iconSize),
          );
        } else if (e.name == 'news') {
          return Tab(
            text: e.name,
            icon: const Icon(Icons.new_label_sharp, size: iconSize),
          );
        } else {
          return Tab(
            text: e.name,
            icon: CircleAvatar(
              radius: DecorationConstants.defaultBorderRadius,
              backgroundColor: ColorConstants.transparant,
              child: AvatarCard(
                photoURL: widget.profileImage ?? StringConstans.randomImageURL,
              ),
            ),
          );
        }
      },
    );
  }
}

class _TabBarView extends StatelessWidget {
  const _TabBarView({
    required TabController tabController,
    required this.profileName,
    required this.profileViewModel,
    required this.profileModel,
    required this.profileImage,
  }) : _tabController = tabController;

  final TabController _tabController;
  final String? profileName;
  final CreateSelectProfileViewModel profileViewModel;

  final ProfileModel? profileModel;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        HomeView(
          profileName: profileName,
          profileViewModel: profileViewModel,
          profileModel: profileModel,
        ),
        Container(
          color: Colors.red,
        ),
        Observer(builder: (_) {
          return MyProfileView(
            profileName: profileName,
            profileImage: profileImage,
          );
        }),
      ],
    );
  }
}
