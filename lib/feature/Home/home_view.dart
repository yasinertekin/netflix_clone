// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Home/home_view_model.dart';
import 'package:netflix_clone/feature/services/movie_service.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/enums/image_enums.dart';

final _trendMovieListViewModel = MovieViewModel(
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
  HomeView({super.key, this.profileName});

  String? profileName;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
          backgroundColor: ColorConstants.black,
          appBar: _MyHomeViewAppBar(),
          body: _trendMovieListViewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return _ContentSection(
                      index: index,
                    );
                  },
                ),
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  PreferredSize _MyHomeViewAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(110),
      child: AppBar(
        backgroundColor: const Color(0xff5e757d),
        title: _AppBarTitleText(
          key,
          profileName,
        ),
        actions: const [
          _TvIconButton(),
          _SearchIconButton(),
        ],
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: _AppBarButtonRow(),
        ),
      ),
    );
  }
}

class _AppBarTitleText extends StatelessWidget {
  String? profileName;

  _AppBarTitleText(
    Key? key,
    this.profileName,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      profileName ?? 'Netflix',
      style: context.textTheme.titleLarge?.copyWith(
        color: ColorConstants.white,
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GradientCardWithOverlay(
          index: index,
        ),
        Text(
          'Trends',
          style: context.textTheme.headlineSmall?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          // ignore: deprecated_member_use
          height: context.dynamicHeight(0.3),
          // ignore: deprecated_member_use
          width: context.dynamicWidth(1),
          child: _CardListPosterBuilder(
            const Key('trendMovieList'), // Benzersiz bir anahtar trendMovieList için
            _trendMovieListViewModel.trendMovieList.length, // Pass the length of the list
            (index) => _trendMovieListViewModel.trendMovieList[index].poster_path!,
          ),
        ),
        Text('Tv Shows',
            style: context.textTheme.headlineSmall?.copyWith(
              color: ColorConstants.white,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: context.dynamicHeight(0.3),
          child: _CardListPosterBuilder(
            const Key('tvShowList'), // Benzersiz bir anahtar tvShowList için
            _trendMovieListViewModel.tvShowList.length, // Pass the length of the list
            (index) => _trendMovieListViewModel.tvShowList[index].poster_path!,
            // Provide a unique key for tvShowList
          ),
        ),
      ],
    );
  }
}

class _SearchIconButton extends StatelessWidget {
  const _SearchIconButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    );
  }
}

class _TvIconButton extends StatelessWidget {
  const _TvIconButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.cast_outlined),
    );
  }
}

class _AppBarButtonRow extends StatelessWidget {
  const _AppBarButtonRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _AppBarTextButton(
          'Diziler',
        ),
        _AppBarTextButton(
          'Filmler',
        ),
        _AppBarTextButton(
          'Kategoriler',
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _AppBarTextButton extends StatelessWidget {
  _AppBarTextButton(this.appBarTextButtonTitle);
  String appBarTextButtonTitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: ColorConstants.transparant,
        side: const BorderSide(color: ColorConstants.white),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Text(
            appBarTextButtonTitle,
            style: const TextStyle(color: ColorConstants.white),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: ColorConstants.white,
          )
        ],
      ),
    );
  }
}

class _GradientCardWithOverlay extends StatelessWidget {
  const _GradientCardWithOverlay({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff5e757d),
            ColorConstants.black.withOpacity(0.5),
          ],
        ),
      ),
      // ignore: deprecated_member_use
      height: context.dynamicHeight(0.5),
      // ignore: deprecated_member_use
      width: context.dynamicWidth(1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _CenteredCardWithOverlayButtons(
          index: index,
        ),
      ),
    );
  }
}

class _CenteredCardWithOverlayButtons extends StatelessWidget {
  const _CenteredCardWithOverlayButtons({required this.index});

  final int index;

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
                    movieID: _trendMovieListViewModel.trendMovieList[1].id!.toString(),
                    moviesModel: _trendMovieListViewModel.trendMovieList[1],
                  );
                },
              ));
            },
            child: const _RoundedImageCard()),
        const _PositionedShadowOverlay(),
        const _ButtonRowPositioned(),
      ],
    );
  }
}

class _RoundedImageCard extends StatelessWidget {
  const _RoundedImageCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          ImageConstants.imagePath + _trendMovieListViewModel.trendMovieList[1].poster_path!,
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
    return Container(
      // ignore: deprecated_member_use
      height: context.dynamicHeight(0.2),
      // ignore: deprecated_member_use
      width: context.dynamicWidth(1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.black.withOpacity(0.0),
            ColorConstants.black.withOpacity(0.5),
          ],
        ),
      ),
    );
  }
}

class _ButtonRowPositioned extends StatelessWidget {
  const _ButtonRowPositioned();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 20,
      child: Row(
        children: [
          _MyPlayButton(),
          SizedBox(
            width: 10,
          ),
          _MyListButton(),
        ],
      ),
    );
  }
}

class _CardListPosterBuilder extends StatelessWidget {
  int count;
  final Function(int index) getImagePath; // Add this property

  _CardListPosterBuilder(
    Key? key,
    this.count,
    this.getImagePath,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (context, index) {
          return _CardListPoster(index, getImagePath(index)); // Pass the index and get the imagePath
        });
  }
}

class _CardListPoster extends StatefulWidget {
  final int index;

  String imagePath; // Add this line to receive the index value

  _CardListPoster(this.index, this.imagePath);
  @override
  State<_CardListPoster> createState() => _CardListPosterState();
}

class _CardListPosterState extends State<_CardListPoster> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // AnimationController'ı etkinleştirirken 'vsync' parametresine 'this' (State) ekleyin.
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // Bu, TickerProvider'ı etkinleştirir.
    );

    // Diğer animasyon işlemleri burada yapılabilir.
  }

  @override
  void dispose() {
    _controller.dispose(); // Animasyon kontrolcüsünü yok edin.
    super.dispose();
  }

  // Update the constructor
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent, // Arka planı şeffaf yapın
              isScrollControlled: true,
              builder: (context) {
                // Başlangıçta alt sayfayı tamamen gizli yapın
                double sheetTopMargin = MediaQuery.of(context).size.height;

                // Animasyon kontrolcüsü oluşturun
                var controller = AnimationController(
                  duration: const Duration(milliseconds: 500), // Animasyon süresini ayarlayın
                  vsync: this, // State sınıfınızın TickerProvider ile uyumlu olduğundan emin olun
                );

                // Animasyon oluşturun
                var animation = Tween(begin: sheetTopMargin, end: 0.0).animate(controller);

                // Animasyon başlatın
                controller.forward();

                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0, animation.value), // Y eksenindeki animasyon değerini kullanın
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          // Alt sayfanızın içeriği burada olacak
                          decoration: const BoxDecoration(
                            color: ColorConstants.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: _trendMovieListViewModel.showMovieDetail
                              ? DetailScreen(
                                  movieID: _trendMovieListViewModel.trendMovieList[widget.index].id!.toString(),
                                  moviesModel: _trendMovieListViewModel.trendMovieList[widget.index],
                                )
                              : DetailScreen(
                                  movieID: _trendMovieListViewModel.tvShowList[widget.index].id!.toString(),
                                  moviesModel: _trendMovieListViewModel.tvShowList[widget.index],
                                ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Card(
            elevation: 50,
            child: SizedBox(
              // ignore: deprecated_member_use
              height: context.dynamicHeight(0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  ImageConstants.imagePath + widget.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
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
      onPressed: () {
        _trendMovieListViewModel.trendMovieList.length;
      },
      child: Row(
        children: [
          const Icon(
            Icons.play_arrow,
            color: ColorConstants.black,
          ),
          Text(
            'Play',
            style: context.textTheme.titleLarge?.copyWith(
              color: ColorConstants.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyListButton extends StatelessWidget {
  const _MyListButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.transparant,
        shadowColor: ColorConstants.transparant,
      ),
      onPressed: () {},
      child: const Row(
        children: [
          Icon(
            Icons.add,
            color: ColorConstants.white,
          ),
          Text('My List'),
        ],
      ),
    );
  }
}
