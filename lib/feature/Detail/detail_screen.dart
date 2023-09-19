import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/index.dart';
import 'package:netflix_clone/product/models/MovieTrailerModel/movie_trailer_model.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final CreateSelectProfileViewModel viewModel = CreateSelectProfileViewModel();

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen({
    super.key,
    this.movieID,
    this.moviesModel,
  });
  String? movieID;
  MoviesModel? moviesModel;
  ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    const bool autoPlay = true;
    const bool mute = true;
    CollectionReference movies = FirebaseFirestore.instance.collection('movies');
    YoutubePlayerController? controller;

    final response = movies
        .withConverter(
          fromFirestore: (snapshot, options) {
            return MovieTrailerModel().fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) {
            // ignore: unnecessary_null_comparison
            if (value == null) throw FirebaseException(plugin: '$value not null');
            return value.toJson();
          },
        )
        .doc(movieID)
        .get();

    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<DocumentSnapshot<MovieTrailerModel>>(
          future: response,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Bağlanti yok'),
                    ],
                  ),
                );

              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.data?.data()?.trailer == null) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Data Yok"),
                    ],
                  );
                } else {
                  controller ??= YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(snapshot.data!.data()!.trailer.toString())!,
                    flags: const YoutubePlayerFlags(
                      autoPlay: autoPlay,
                      mute: mute,
                    ),
                  );
                }

                return Column(
                  children: [
                    _CustomVideoPlayerView(controller: controller),
                    Padding(
                      padding: context.padding.low * 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailScreenMovieTitle(context),
                          _MovieStatsBar(moviesModel: moviesModel),
                          const _DetailScreenLikeButton(),
                          const _DetailScreenPlayButton(),
                          const _DetailScreenDownloadButton(),
                          _detailScreenMovieOverview(),
                          const _CastTitleText(),
                          const _DirectorText(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Observer(
                                builder: (_) {
                                  return CheckListButton(
                                      isRowText: false,
                                      isColumnText: true,
                                      moviesModel: moviesModel,
                                      viewModel: viewModel,
                                      profileModel: profileModel);
                                },
                              ),
                              const Column(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined),
                                  Text(StringConstans.rate),
                                ],
                              ),
                              const Column(
                                children: [
                                  Icon(Icons.share),
                                  Text(StringConstans.share),
                                ],
                              ),
                              Divider(
                                endIndent: context.general.mediaQuery.size.width * 0.2,
                                color: ColorConstants.red,
                                thickness: 6,
                              ),
                            ],
                          ),
                          const _SimilarMoviesText(),
                        ],
                      ),
                    ),
                  ],
                );
            }
          },
        ));
  }

  Text _detailScreenMovieOverview() {
    return Text(
      moviesModel!.overview.toString(),
    );
  }

  Text _detailScreenMovieTitle(BuildContext context) {
    return Text(
      moviesModel!.media_type == StringConstans.mediTypeMovie
          ? moviesModel!.title.toString()
          : moviesModel!.name.toString(),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorConstants.white,
          ),
    );
  }
}

class CheckListButton extends StatefulWidget {
  const CheckListButton({
    super.key,
    required this.moviesModel,
    required this.viewModel,
    required this.profileModel,
    required this.isRowText,
    required this.isColumnText,
  });

  final MoviesModel? moviesModel;
  final CreateSelectProfileViewModel viewModel;
  final ProfileModel? profileModel;
  final bool isRowText;
  final bool isColumnText;

  @override
  State<CheckListButton> createState() => _CheckListButtonState();
}

class _CheckListButtonState extends State<CheckListButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // AnimationController oluşturun ve dönüş açısını ayarlayın (0 ile 360 derece arası)
    _controller = AnimationController(vsync: this, duration: context.duration.durationLow // Animasyon süresi
        );

    // Animasyonu başlatın
    _controller.forward();
  }

  @override
  void dispose() {
    // Belleği sızdırmamak için animasyon denetleyiciyi kapatın
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Observer(
                builder: (_) =>
                    // Eğer favori ise

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.transparant,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            DecorationConstants.verylowBorderRadius,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (homeViewModel.isFavorite) {
                          await viewModel.removeFavoriteMovie(
                            FirebaseAuth.instance.currentUser!.uid,
                            widget.moviesModel!,
                          );
                        } else {
                          await viewModel.addFavoriteMovie(
                            FirebaseAuth.instance.currentUser!.uid,
                            widget.moviesModel!,
                          );
                        }

                        // Animasyonu yeniden başlat
                        _controller.reset();
                        _controller.forward(); // Animasyonu başlat

                        // Diğer işlemler buraya gelebilir
                      },
                      child: Row(
                        children: [
                          Column(
                            children: [
                              RotationTransition(
                                alignment: Alignment.center,
                                turns: Tween(begin: -0.5, end: 0.0).animate(_controller),
                                child: Column(
                                  children: [
                                    Icon(
                                      homeViewModel.isFavorite ? Icons.check : Icons.add,
                                      color: ColorConstants.white,
                                    ),
                                  ],
                                ),
                              ),
                              widget.isColumnText
                                  ? Text(
                                      homeViewModel.isFavorite ? StringConstans.mylist : StringConstans.addMovie,
                                      style: context.general.textTheme.bodyMedium?.copyWith(
                                        color: ColorConstants.white,
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                          widget.isRowText
                              ? Text(
                                  StringConstans.mylist,
                                  style: context.general.textTheme.bodyMedium?.copyWith(
                                    color: ColorConstants.white,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    )

                // Eğer favori değil ise

                ),
          ],
        ),
      ],
    );
  }
}

class _CustomVideoPlayerView extends StatelessWidget {
  const _CustomVideoPlayerView({
    required this.controller,
  });

  final YoutubePlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(
          DecorationConstants.defaultBorderRadius,
        ),
        topRight: Radius.circular(
          DecorationConstants.defaultBorderRadius,
        ),
      ),
      child: YoutubePlayer(
        progressColors: const ProgressBarColors(
          playedColor: ColorConstants.red,
          handleColor: ColorConstants.red,
        ),
        bufferIndicator: const CircularProgressIndicator(),
        showVideoProgressIndicator: true,
        bottomActions: [
          const SizedBox(
            width: DecorationConstants.defaultBorderRadius,
          ),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 8.0),
          RemainingDuration(),
          const PlaybackSpeedButton(),
        ],
        controller: controller!,
        liveUIColor: ColorConstants.red,
      ),
    );
  }
}

class _SimilarMoviesText extends StatelessWidget {
  const _SimilarMoviesText();

  @override
  Widget build(BuildContext context) {
    return Text(
      StringConstans.similarMovies,
      style: context.general.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DirectorText extends StatelessWidget {
  const _DirectorText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          StringConstans.share,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          StringConstans.robertZemeckis,
          style: context.general.textTheme.bodyMedium?.copyWith(),
        ),
      ],
    );
  }
}

class _CastTitleText extends StatelessWidget {
  const _CastTitleText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          StringConstans.cast,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          StringConstans.tomHanks,
          style: context.general.textTheme.bodyMedium?.copyWith(),
        ),
        const _MoreInfoTextButton(),
      ],
    );
  }
}

class _MoreInfoTextButton extends StatelessWidget {
  const _MoreInfoTextButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        StringConstans.moreInfo,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.white,
        ),
      ),
    );
  }
}

class _DetailScreenDownloadButton extends StatelessWidget {
  const _DetailScreenDownloadButton();
  final int _colorValue = 800;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorConstants.white,
          backgroundColor: Colors.grey[_colorValue],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {},
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download),
            Text(StringConstans.download),
          ],
        ));
  }
}

class _DetailScreenPlayButton extends StatelessWidget {
  const _DetailScreenPlayButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorConstants.black,
        backgroundColor: ColorConstants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            DecorationConstants.verylowBorderRadius,
          ),
        ),
      ),
      onPressed: () {},
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow),
          Text(StringConstans.play),
        ],
      ),
    );
  }
}

class _DetailScreenLikeButton extends StatelessWidget {
  const _DetailScreenLikeButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          color: ColorConstants.red,
          child: Padding(
            padding: context.padding.low,
            child: const Icon(
              Icons.thumb_up_rounded,
              color: ColorConstants.white,
            ),
          ),
        ),
        Text(
          StringConstans.muchAppreciated,
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _MovieStatsBar extends StatelessWidget {
  const _MovieStatsBar({
    required this.moviesModel,
  });

  final MoviesModel? moviesModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const MovieStatsBarMatch(),
        _MovieStatsBarYear(moviesModel: moviesModel),
        const _MovieStatsBarRestrictionCard(),
        const _MovieStatsBarMovieLength(),
        const _MovieStatsBarMovieHDQualityTag(),
      ],
    );
  }
}

class _MovieStatsBarMovieHDQualityTag extends StatelessWidget {
  const _MovieStatsBarMovieHDQualityTag();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: ColorConstants.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          DecorationConstants.verylowBorderRadius,
        ),
      ),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(DecorationConstants.lowPadding),
        child: Text(
          StringConstans.hd,
          style: context.general.textTheme.bodySmall?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _MovieStatsBarMovieLength extends StatelessWidget {
  const _MovieStatsBarMovieLength();

  @override
  Widget build(BuildContext context) {
    return Text(
      StringConstans.duration,
      style: context.general.textTheme.bodyMedium?.copyWith(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _MovieStatsBarRestrictionCard extends StatelessWidget {
  const _MovieStatsBarRestrictionCard();
  final double _width = 1;
  final int _colorValue = 800;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[_colorValue],
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent, width: _width),
        borderRadius: BorderRadius.circular(
          DecorationConstants.verylowBorderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DecorationConstants.lowPadding),
        child: Text(
          StringConstans.adult,
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _MovieStatsBarYear extends StatelessWidget {
  const _MovieStatsBarYear({
    required this.moviesModel,
  });

  final MoviesModel? moviesModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      moviesModel!.releaseDate != null ? moviesModel!.releaseDate! : StringConstans.year,
      style: context.general.textTheme.bodyMedium?.copyWith(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MovieStatsBarMatch extends StatelessWidget {
  const MovieStatsBarMatch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      StringConstans.match,
      style: context.general.textTheme.bodyMedium?.copyWith(
        color: ColorConstants.green,
      ),
    );
  }
}
