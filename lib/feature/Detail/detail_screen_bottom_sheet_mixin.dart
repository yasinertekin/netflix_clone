import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Detail/detail_screen_bottom_sheet.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/index.dart';

mixin DetailScreenBottomSheetMixin on State<CardListPoster> {
  void showDetailScreenBottomSheet() {
    const bool isControlled = true;
    const double leftPaddingValue = 1;
    const double rightPaddingValue = 1;

    showModalBottomSheet(
      context: context,
      backgroundColor: ColorConstants.transparant,
      isScrollControlled: isControlled,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: leftPaddingValue,
            right: rightPaddingValue,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            // Alt sayfanızın içeriği burada olacak
            decoration: const BoxDecoration(
              color: ColorConstants.dirtyPink,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(DecorationConstants.veryHighBorderRadius),
                topRight: Radius.circular(DecorationConstants.veryHighBorderRadius),
              ),
            ),
            child: widget.mediaType == StringConstans.mediTypeMovie
                ? DetailScreen(
                    movieID: homeViewModel.trendMovieList[widget.index!].id?.toString() ?? "",
                    moviesModel: homeViewModel.trendMovieList[widget.index!],
                  )
                : DetailScreen(
                    movieID: homeViewModel.tvShowList[widget.index!].id?.toString() ?? "",
                    moviesModel: homeViewModel.tvShowList[widget.index!],
                  ),
          ),
        );
      },
    );
  }
}
