import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/Search/search_view.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

mixin SearchViewMixin on State<SearchView> {
  void findAndSet(String key) {
    homeViewModel.items = widget.model
            .getValues()
            ?.where((element) =>
                (element.title?.toLowerCase().contains(key.toLowerCase()) ?? false) ||
                (element.name?.toLowerCase().contains(key.toLowerCase()) ?? false))
            .toSet()
            .toList() ??
        [];
  }

  void showDetailBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 1,
            right: 1,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.98,
            // Alt sayfanızın içeriği burada olacak
            decoration: const BoxDecoration(
              color: ColorConstants.dirtyPink,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),

            child: homeViewModel.items[index] == 'movie'
                ? DetailScreen(
                    movieID: homeViewModel.items[index].id!.toString(),
                    moviesModel: homeViewModel.items[index],
                  )
                : DetailScreen(
                    movieID: homeViewModel.items[index].id!.toString(),
                    moviesModel: homeViewModel.items[index],
                  ),
          ),
        );
      },
    );
  }
}
