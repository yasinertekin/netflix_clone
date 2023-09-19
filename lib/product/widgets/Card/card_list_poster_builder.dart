import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/feature/Detail/detail_screen_bottom_sheet.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';

class CardListPosterBuilder extends StatelessWidget {
  final int count;
  final String mediaType;
  final Function(int index) getImagePath;

  const CardListPosterBuilder({
    Key? key,
    required this.count,
    required this.getImagePath,
    required this.mediaType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final ScrollDirection directions = notification.direction;
        if (directions == ScrollDirection.forward) {
          homeViewModel.setIsHorizantalScrolling(false);
        } else if (directions == ScrollDirection.reverse) {
          homeViewModel.setIsHorizantalScrolling(false);
        } else if (directions == ScrollDirection.idle) {
          homeViewModel.setIsHorizantalScrolling(true);
        }

        return true;
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (context, index) {
          return CardListPoster(
            imagePath: getImagePath(index),
            mediaType: mediaType,
            index: index,
            viewModel: homeViewModel,
          );
        },
      ),
    );
  }
}
