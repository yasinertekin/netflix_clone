import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/feature/Home/HomeScreenList/movie_list.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

mixin MovieListMixin on State<MovieList> {
  ScrollController changeAppBarColor() {
    ScrollController scrollController = ScrollController();
    const int trashHold = 65;
    const int zero = 0;
    const double colorOpacity = 0.7;
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;

      if (pixels == zero) {
        homeViewModel.appBarColor = ColorConstants.winterHorror;
      } else if (pixels > zero && pixels < trashHold) {
        homeViewModel.appBarColor = Color.lerp(
            ColorConstants.winterHorror, ColorConstants.black.withOpacity(colorOpacity), pixels / trashHold)!;
      } else {
        homeViewModel.appBarColor = ColorConstants.black.withOpacity(colorOpacity);
      }
    });
    return scrollController;
  }

  bool listViewScrollController(UserScrollNotification notification) {
    final ScrollDirection direction = notification.direction;
    if (direction == ScrollDirection.forward) {
      homeViewModel.setIsScrolling(true);
    } else if (direction == ScrollDirection.reverse) {
      homeViewModel.setIsScrolling(false);
    }
    return true;
  }
}
