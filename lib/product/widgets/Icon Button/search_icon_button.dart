import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Search/search_view.dart';
import 'package:netflix_clone/product/cache_manager/movie_cache_manager.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

class SearchIconButton extends StatelessWidget {
  const SearchIconButton({super.key, required this.cacheManager});
  final ICacheManager<MoviesModel> cacheManager;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.route.navigateToPage(SearchView(model: cacheManager));
      },
      icon: const Icon(Icons.search),
    );
  }
}
