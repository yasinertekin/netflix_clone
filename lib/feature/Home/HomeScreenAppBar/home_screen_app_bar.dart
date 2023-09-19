import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view_model.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/cache_manager/movie_cache_manager.dart';
import 'package:netflix_clone/product/constants/animate_duration_constants.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:netflix_clone/product/widgets/Icon%20Button/search_icon_button.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/home_app_bar_row_button.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
    required this.profileName,
    required this.viewModel,
    required this.cacheManager,
    required this.profileViewModel,
  });

  final String? profileName;
  final MovieViewModel viewModel;
  final ICacheManager<MoviesModel> cacheManager;
  final CreateSelectProfileViewModel profileViewModel;

  @override
  Widget build(BuildContext context) {
    homeViewModel.selectedName = profileName!;
    return AppBar(
      bottom: homeViewModel.isScrolling
          ? const PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox.shrink())
          : PreferredSize(
              preferredSize: Size.fromHeight(context.general.mediaQuery.size.height),
              child: HomeAppBarBottom(
                viewModel: viewModel,
              ),
            ),
      automaticallyImplyLeading: false,
      backgroundColor: ColorConstants.winterHorror,
      title: AppBarTitleText(
        profileName,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.cast_outlined,
          ),
        ),
        SearchIconButton(
          cacheManager: cacheManager,
        ),
      ],
      elevation: 0,
    );
  }
}

class _CloseIconButton extends StatelessWidget {
  const _CloseIconButton({
    required this.viewModel,
  });

  final MovieViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final double radiusSize = context.general.mediaQuery.size.width * 0.04;
    return InkWell(
      onTap: () {
        _closeIconButtonFun();
      },
      child: Card(
        elevation: 0,
        color: ColorConstants.transparant,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: ColorConstants.white,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              DecorationConstants.defaultBorderRadius,
            ),
          ),
        ),
        child: CircleAvatar(
          backgroundColor: ColorConstants.transparant,
          radius: radiusSize,
          child: const Icon(
            Icons.close,
            color: ColorConstants.white,
          ),
        ),
      ),
    );
  }

  void _closeIconButtonFun() {
    viewModel.toggleDetailType();
    if (viewModel.showTvShow) {
      viewModel.toggleDetailType();
      viewModel.toggleTvShow();
    }
  }
}

// ignore: must_be_immutable
class AppBarTitleText extends StatelessWidget {
  String? profileName;

  AppBarTitleText(this.profileName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      profileName ?? StringConstans.netflix,
      style: context.general.textTheme.titleLarge?.copyWith(
        color: ColorConstants.white,
      ),
    );
  }
}

class HomeAppBarBottom extends StatelessWidget {
  const HomeAppBarBottom({
    super.key,
    required this.viewModel,
  });

  final MovieViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final key = viewModel.showMovie || viewModel.showTvShow ? 'start' : 'spaceEvenly';
    return Observer(builder: (_) {
      return AnimatedContainer(
        duration: context.duration.durationNormal,
        height: homeViewModel.isScrolling
            ? context.general.mediaQuery.size.height * 0.00
            : context.general.mediaQuery.size.height * 0.06,
        curve: Curves.easeIn,
        transformAlignment: Alignment.center,
        color: homeViewModel.isScrolling ? ColorConstants.black : ColorConstants.transparant,
        child: Row(
          key: Key(key),
          mainAxisAlignment:
              viewModel.showMovie || viewModel.showTvShow ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
          children: [
            _closeIconButtonBuilder(),
            buildMoviesTextButton(),
            buildTvShowsTextButton(),
            HomeAppBarRowButton(
              isIcon: false,
              viewModel: viewModel,
              buttonTitle: StringConstans.mylist,
            ),
          ],
        ),
      );
    });
  }

  Widget buildTvShowsTextButton() {
    return viewModel.showMovie
        ? const SizedBox.shrink()
        : HomeAppBarRowButton(
            buttonTitle: StringConstans.tvShows,
            viewModel: viewModel,
          );
  }

  Widget buildMoviesTextButton() {
    return viewModel.showTvShow
        ? const SizedBox.shrink()
        : HomeAppBarRowButton(
            buttonTitle: StringConstans.movies,
            viewModel: viewModel,
          );
  }

  AnimatedSwitcher _closeIconButtonBuilder() {
    return viewModel.showMovie || viewModel.showTvShow
        ? AnimatedSwitcher(
            duration: const Duration(
              milliseconds: AnimateDurationConstants.defaultAnimateDuration,
            ),
            child: _CloseIconButton(
              viewModel: viewModel,
            ),
          )
        : const AnimatedSwitcher(
            duration: Duration(
              milliseconds: AnimateDurationConstants.shortAnimateDuration,
            ),
            child: SizedBox.shrink(),
          );
  }
}
