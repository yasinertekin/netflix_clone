import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/product/models/MovieTrailerModel/movie_trailer_model.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen({
    super.key,
    this.movieID,
    this.moviesModel,
  });
  String? movieID;
  MoviesModel? moviesModel;

  @override
  Widget build(BuildContext context) {
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
                    autoPlay: true,
                    mute: true,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: context.onlyTopPaddingMedium,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          YoutubePlayer(
                            bufferIndicator: const CircularProgressIndicator(),
                            showVideoProgressIndicator: true,
                            bottomActions: [
                              const SizedBox(width: 14.0),
                              CurrentPosition(),
                              const SizedBox(width: 8.0),
                              ProgressBar(isExpanded: true),
                              const SizedBox(width: 8.0),
                              RemainingDuration(),
                              const PlaybackSpeedButton(),
                            ],
                            controller: controller!,
                            liveUIColor: Colors.red,
                          ),
                          Padding(
                            padding: context.paddingLow,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /*     InkWell(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.grey[800],
                                    child: Padding(
                                      padding: context.paddingLow,
                                      child: const Icon(
                                        Icons.cast,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.grey[800],
                                    child: Padding(
                                      padding: context.paddingLow,
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            moviesModel!.media_type == 'movie'
                                ? Text(
                                    moviesModel!.title.toString(),
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  )
                                : Text(
                                    moviesModel!.name.toString(),
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                            _MovieStatsBar(moviesModel: moviesModel),
                            Row(
                              children: [
                                Card(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: context.padding.low,
                                    child: const Icon(
                                      Icons.thumb_up_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Much Appreciated',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_arrow),
                                  Text('Play'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.grey[800],
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
                                    Text('Download'),
                                  ],
                                )),
                            Text(
                              moviesModel!.overview.toString(),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Cast:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Tom Hanks, Robin Wright,Gary Sinise ...',
                                  style: context.textTheme.bodyMedium?.copyWith(),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'More Info',
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Director:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Robert Zemeckis',
                                  style: context.textTheme.bodyMedium?.copyWith(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                                    const Text('My List'),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Icon(Icons.thumb_up_alt_outlined),
                                    Text('Rate'),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Icon(Icons.share),
                                    Text('Share'),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                            Divider(
                              endIndent: context.dynamicWidth(0.6),
                              color: Colors.red,
                              thickness: 6,
                            ),
                            Text(
                              'Similar Movies',
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
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
        side: const BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          ' HD ',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.white,
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
      '2hr. 22min. ',
      style: context.textTheme.bodyMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _MovieStatsBarRestrictionCard extends StatelessWidget {
  const _MovieStatsBarRestrictionCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          '18+',
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
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
      moviesModel!.releaseDate != null ? moviesModel!.releaseDate! : '2021',
      style: context.textTheme.bodyMedium?.copyWith(
        color: Colors.white,
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
      '%96 Match ',
      style: context.textTheme.bodyMedium?.copyWith(
        color: Colors.green,
      ),
    );
  }
}
