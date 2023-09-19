import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kartal/kartal.dart';

import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/double_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';
import 'package:netflix_clone/product/widgets/Card/card_list_poster_builder.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    super.key,
    required this.viewModel,
    required this.moviesModel,
    required this.profileModel,
  });

  @override
  State<MovieList> createState() => _MovieListState();

  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.forward) {
          homeViewModel.setIsScrolling(false);
        } else if (notification.direction == ScrollDirection.reverse) {
          homeViewModel.setIsScrolling(true);
        } else if (notification.direction == ScrollDirection.idle) {
          homeViewModel.setIsScrolling(false);
        }

        return true;
      },
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return _ContentSection(
            index: index,
            viewModel: widget.viewModel,
            moviesModel: widget.moviesModel,
            profileModel: widget.profileModel,
          );
        },
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection(
      {required this.index, required this.viewModel, required this.moviesModel, required this.profileModel});
  final int index;
  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientCardWithOverlay(
          moviesModel: moviesModel,
          profileModel: profileModel,
          viewModel: viewModel,
          index: index,
        ),
        homeViewModel.showTvShow
            ? const SizedBox.shrink()
            : _TrendMovie(
                index: index,
              ),
        _TvShows(
          index: index,
        )
      ],
    );
  }
}

class _TrendMovie extends StatelessWidget {
  const _TrendMovie({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    // Verileri bir kez alın ve saklayın

    final movies = homeViewModel.trendMovieList.where((movie) => movie.media_type == 'movie').toSet().toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TrendMovieListTitle(),
        SizedBox(
          height: context.general.mediaQuery.size.height * DoubleConstants.defaultPosterListHeight,
          width: context.general.mediaQuery.size.width,
          child: CardListPosterBuilder(
            getImagePath: (index) => movies[index].poster_path!,
            mediaType: movies[index].media_type!,
            count: movies.length,
          ),
        ),
      ],
    );
  }
}

class _TvShows extends StatelessWidget {
  const _TvShows({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final tvShows = homeViewModel.tvShowList;
    final nonFavoriteTvShows = tvShows.where((tvShow) => tvShow.media_type == 'tv').toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TvShowsTitle(),
        SizedBox(
          height: context.general.mediaQuery.size.height * DoubleConstants.defaultPosterListHeight,
          width: context.general.mediaQuery.size.width,
          child: CardListPosterBuilder(
            getImagePath: (index) => nonFavoriteTvShows[index].poster_path!,
            mediaType: nonFavoriteTvShows[index].media_type!,
            count: nonFavoriteTvShows.length,
          ),
        ),
      ],
    );
  }
}

class _TvShowsTitle extends StatelessWidget {
  const _TvShowsTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      StringConstans.tvShows,
      style: context.general.textTheme.headlineSmall?.copyWith(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TrendMovieListTitle extends StatelessWidget {
  const _TrendMovieListTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      StringConstans.trends,
      style: context.general.textTheme.headlineSmall?.copyWith(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
