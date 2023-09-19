import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/Search/search_view_mixin.dart';
import 'package:netflix_clone/product/cache_manager/movie_cache_manager.dart';
import 'package:netflix_clone/product/constants/decoration_constants.dart';
import 'package:netflix_clone/product/constants/index.dart';
import 'package:netflix_clone/product/enums/image_enums.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.model});

  final ICacheManager<MoviesModel> model;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SearchViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        centerTitle: true,
        title: _searchTextField(),
        backgroundColor: ColorConstants.transparant,
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) => Expanded(
            child: favoriMovieList(),
          ),
        ),
      ),
    );
  }

  ListView favoriMovieList() {
    return ListView.builder(
      itemCount: homeViewModel.items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.padding.low,
          child: InkWell(
            onTap: () {
              showDetailBottomSheet(context, index);
            },
            child: BackdropCard(
              backdrop_path: homeViewModel.items[index].backdrop_path!,
              name: homeViewModel.items[index].title ?? homeViewModel.items[index].name!,
              index: index,
            ),
          ),
        );
      },
    );
  }

  TextField _searchTextField() {
    return TextField(
      autofocus: true,
      onChanged: (value) {
        findAndSet(value);
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: StringConstans.search,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(DecorationConstants.highBorderRadius),
          ),
        ),
        contentPadding: EdgeInsets.all(DecorationConstants.defaultPadding),
      ),
    );
  }
}

class BackdropCard extends StatelessWidget {
  const BackdropCard({
    super.key,
    required this.index,
    required this.name,
    required this.backdrop_path,
  });
  final int index;
  final String name;
  final String backdrop_path;

  @override
  Widget build(BuildContext context) {
    const int flexValue = 3;
    const int secondFlexValue = 2;
    const double textSize = 15;
    const double cardElevation = 50;
    const double iconSize = 40;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: flexValue,
          child: Card(
            elevation: cardElevation,
            color: ColorConstants.transparant,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                DecorationConstants.defaultBorderRadius,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                DecorationConstants.defaultBorderRadius,
              ),
              child: Card(
                child: Image.network(
                  ImageConstants.imagePath + backdrop_path,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: secondFlexValue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: context.padding.low,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const Expanded(
          flex: 1,
          child: Icon(
            Icons.play_circle_outlined,
            size: iconSize,
          ),
        ),
      ],
    );
  }
}
