import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Home/home_view.dart';
import 'package:netflix_clone/feature/Profile/profile_view.dart';

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
    _tabController =
        TabController(length: _MyTabViews.values.length, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    const notchedValue = 10.0;
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          height: context.dynamicHeight(0.1),
          color: Colors.black,
          notchMargin: notchedValue,
          child: _MyTabView(),
        ),
        body: _tabBarView(tabController: _tabController, profileName: widget.profileName),
      ),
    );
  }

  _MyTabView() {
    return SizedBox(
        child: TabBar(
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,

      // isScrollable: true,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      padding: EdgeInsets.zero,
      onTap: (value) {
        //int value
      },
      controller: _tabController,
      tabs: _MyTabViews.values.map((e) {
        if (e.name == 'Home') {
          return Tab(
            text: e.name,
            icon: const Icon(Icons.home, size: 22),
          );
        } else if (e.name == 'New') {
          return Tab(
            text: e.name,
            icon: const Icon(Icons.new_label_sharp, size: 22),
          );
        } else {
          // Diğer durumlar için bir resim göstermek isterseniz, Image.asset veya Image.network kullanabilirsiniz.
          // Aşağıda örnek bir Image.network kullanımı verilmiştir:
          return Tab(
            text: e.name,
            icon: SizedBox(
              width: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  height: 45,
                  fit: BoxFit.cover,
                  widget.profileImage!,
                ),
              ),
            ),
          );
        }
      }).toList(),
    ));
  }
}

class _tabBarView extends StatelessWidget {
  const _tabBarView({
    required TabController tabController,
    required this.profileName,
  }) : _tabController = tabController;

  final TabController _tabController;
  final String? profileName;

  @override
  Widget build(BuildContext context) {
    return TabBarView(physics: const NeverScrollableScrollPhysics(), controller: _tabController, children: [
      HomeView(
        profileName: profileName,
      ),
      Container(
        color: Colors.red,
      ),
      const ProfileView(),
    ]);
  }
}

enum _MyTabViews { Home, New, Profile }

extension _MyTabViewExtension on _MyTabViews {}
