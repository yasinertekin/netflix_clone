import 'package:flutter/material.dart';

import '../models/OnBoardScreenModel/onboard_screen_model.dart';

class CustomTabIndicator extends StatefulWidget {
  const CustomTabIndicator({super.key, required this.selectedIndex});
  final int? selectedIndex;

  @override
  State<CustomTabIndicator> createState() => _TabIndicatorState();
}

class _TabIndicatorState extends State<CustomTabIndicator> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void didUpdateWidget(covariant CustomTabIndicator oldWidget) {
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: OnBoardScreenModels.onboardScreenItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabPageSelector(
      controller: _tabController,
      selectedColor: Colors.red,
      color: Colors.grey,
      indicatorSize: 10,
      borderStyle: BorderStyle.none,
    );
  }
}
