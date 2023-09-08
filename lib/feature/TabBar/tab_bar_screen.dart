import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Home/home_view.dart';
import 'package:netflix_clone/feature/Profile/Profile%20View/profile_view.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/enums/tab_bar_enums.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';

// ignore: must_be_immutable
class TabBarScreen extends StatefulWidget {
  TabBarScreen({super.key, this.profileName, this.profileImage, this.initialTabIndex = 0});

  String? profileName;
  String? profileImage;
  final int initialTabIndex;

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: MyTabviews.values.length, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyTabviews.values.length,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: myTabView(),
        ),
        body: _TabBarView(tabController: _tabController, profileName: widget.profileName),
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
      padding: EdgeInsets.zero,
      onTap: (value) {
        //int value
      },
      controller: _tabController,
      tabs: MyTabviews.values.map((e) {
        if (e.name == 'home') {
          return Tab(
            text: e.name,
            icon: const Icon(Icons.home, size: 20),
          );
        } else if (e.name == 'news') {
          return Tab(
            text: e.name,
            icon: const Icon(Icons.new_label_sharp, size: 20),
          );
        } else {
          return Tab(
            text: e.name,
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: AvatarCard(
                photoURL: widget.profileImage ?? StringConstans.randomImageURL,
              ),
            ),
          );
        }
      }).toList(),
    );
  }
}

class _TabBarView extends StatelessWidget {
  const _TabBarView({
    required TabController tabController,
    required this.profileName,
  }) : _tabController = tabController;

  final TabController _tabController;
  final String? profileName;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        HomeView(
          profileName: profileName,
        ),
        Container(
          color: Colors.red,
        ),
        const ProfileView(),
      ],
    );
  }
}
