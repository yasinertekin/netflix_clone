import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/My%20List%20Screen/my_list_screen.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

mixin MyListScreenMixin on State<MyListScreen> {
  void showDetailScreenBottomSheet(int index) {
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

            child: homeViewModel.favoriteList[index] == StringConstans.mediTypeMovie
                ? DetailScreen(
                    movieID: homeViewModel.favoriteList[index].id!.toString(),
                    moviesModel: homeViewModel.favoriteList[index],
                  )
                : DetailScreen(
                    movieID: homeViewModel.favoriteList[index].id!.toString(),
                    moviesModel: homeViewModel.favoriteList[index],
                  ),
          ),
        );
      },
    );
  }

  List<MoviesModel> parseMovies(List<dynamic> moviesList) {
    homeViewModel.favoriteList.clear();

    for (var movieData in moviesList) {
      MoviesModel movie = MoviesModel.fromJson(Map<String, dynamic>.from(movieData));
      homeViewModel.favoriteList.add(movie);
    }
    return homeViewModel.favoriteList;
  }

  bool natificationListener(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.forward) {
      homeViewModel.setIsScrolling(false);
    } else if (notification.direction == ScrollDirection.reverse) {
      homeViewModel.setIsScrolling(false);
    } else if (notification.direction == ScrollDirection.idle) {
      homeViewModel.setIsScrolling(false);
    }
    return true;
  }

  Future<dynamic> showConfirmDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text("Do you want to remove this item?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("DELETE"),
          ),
        ],
      ),
    );
    return result;
  }
}
