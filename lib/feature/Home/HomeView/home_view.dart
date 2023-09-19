import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Home/HomeScreenAppBar/home_screen_app_bar.dart';
import 'package:netflix_clone/feature/Home/HomeScreenList/movie_list.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view_model.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/feature/services/movie_service.dart';
import 'package:netflix_clone/product/cache_manager/movie_cache_manager.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/double_constants.dart';
import 'package:netflix_clone/product/enums/image_enums.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';

import '../../../product/constants/string_constants.dart';

final homeViewModel = MovieViewModel(
  cacheManager: MovieCacheManager('movies5'),
  service: MoviesService(
    Dio(
      BaseOptions(
        baseUrl: ServicePath.BASEURL.rawValue,
      ),
    ),
  ),
);

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key, this.profileName, required this.profileViewModel, required this.profileModel});

  String? profileName;
  final CreateSelectProfileViewModel profileViewModel;
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              DecorationConstants.defaultAppBarHeight * context.general.mediaQuery.size.height,
            ),
            child: HomeScreenAppBar(
              profileName: profileName,
              viewModel: homeViewModel,
              cacheManager: homeViewModel.cacheManager,
              profileViewModel: profileViewModel,
            ),
          ),
          backgroundColor: ColorConstants.black,
          body: homeViewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MovieList(
                  viewModel: profileViewModel,
                  moviesModel: homeViewModel.trendMovieList[1],
                  profileModel: profileModel,
                ));
    });
  }
}

class GradientCardWithOverlay extends StatelessWidget {
  const GradientCardWithOverlay(
      {super.key, required this.index, required this.moviesModel, required this.viewModel, required this.profileModel});
  final int index;
  final double colorOpacity = 0.7;
  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorConstants.winterHorror,
                ColorConstants.black.withOpacity(colorOpacity),
              ],
            ),
          ),
          height: context.general.mediaQuery.size.height * DoubleConstants.highAvatarCardHeight,
          width: context.general.mediaQuery.size.width,
          child: Padding(
            padding: context.padding.low,
            child: CenteredCardWithOverlayButtons(
              moviesModel: moviesModel,
              profileModel: profileModel,
              viewModel: viewModel,
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}

class CenteredCardWithOverlayButtons extends StatelessWidget {
  const CenteredCardWithOverlayButtons(
      {super.key, required this.index, this.moviesModel, required this.viewModel, required this.profileModel});

  final int index;

  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DetailScreen(
                    movieID: homeViewModel.trendMovieList[1].id!.toString(),
                    moviesModel: homeViewModel.trendMovieList[1],
                  );
                },
              ));
            },
            child: const _RoundedImageCard()),
        const _PositionedShadowOverlay(),
        _ButtonRowPositioned(
          moviesModel: moviesModel,
          profileModel: profileModel,
          viewModel: viewModel,
        ),
      ],
    );
  }
}

class _RoundedImageCard extends StatelessWidget {
  const _RoundedImageCard();

  @override
  Widget build(BuildContext context) {
    const double cardElevation = 50;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DecorationConstants.lowBorderRadius),
      ),
      elevation: cardElevation,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DecorationConstants.lowBorderRadius),
        child: Image.network(
          ImageConstants.imagePath + homeViewModel.trendMovieList[1].poster_path!,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class _PositionedShadowOverlay extends StatelessWidget {
  const _PositionedShadowOverlay();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 0,
      child: _ShadowOverlay(),
    );
  }
}

class _ShadowOverlay extends StatelessWidget {
  const _ShadowOverlay();

  @override
  Widget build(BuildContext context) {
    const double colorOpacity = 0.0;
    const double colorOpacity2 = 0.5;
    return Container(
      height: context.general.mediaQuery.size.height * DoubleConstants.defaultAvatarCardHeight,
      // ignore: deprecated_member_use
      width: context.general.mediaQuery.size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.black.withOpacity(colorOpacity),
            ColorConstants.black.withOpacity(colorOpacity2),
          ],
        ),
      ),
    );
  }
}

class _ButtonRowPositioned extends StatelessWidget {
  const _ButtonRowPositioned({
    required this.viewModel,
    required this.profileModel,
    required this.moviesModel,
  });

  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Row(
        children: [
          const _MyPlayButton(),
          const SizedBox(
            width: 10,
          ),
          _MyListButton(
            moviesModel: moviesModel,
            profileModel: profileModel,
            viewModel: viewModel,
          ),
        ],
      ),
    );
  }
}

class _MyPlayButton extends StatelessWidget {
  const _MyPlayButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.white,
        shadowColor: ColorConstants.transparant,
      ),
      onPressed: () {},
      child: Row(
        children: [
          const Icon(
            Icons.play_arrow,
            color: ColorConstants.black,
          ),
          Text(
            StringConstans.play,
            style: context.general.textTheme.titleLarge?.copyWith(
              color: ColorConstants.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyListButton extends StatelessWidget {
  const _MyListButton({
    required this.moviesModel,
    required this.viewModel,
    required this.profileModel,
  });

  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return CheckListButton(
      isRowText: true,
      isColumnText: false,
      moviesModel: moviesModel,
      profileModel: profileModel,
      viewModel: viewModel,
    );
  }
}
