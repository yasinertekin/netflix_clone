import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:netflix_clone/feature/services/movie_service.dart';
import 'package:netflix_clone/product/cache_manager/movie_cache_manager.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

part 'home_view_model.g.dart';

// ignore: library_private_types_in_public_api
class MovieViewModel = _MovieViewModelBase with _$MovieViewModel;

abstract class _MovieViewModelBase with Store {
  @observable
  bool isLoading = true;

  @observable
  bool isFavorite = true;

  @observable
  List<MoviesModel> trendMovieList = [];
  @observable
  List<MoviesModel> favoriteList = [];
  @observable
  Color appBarColor = const Color(0xff5e757d);

  @observable
  List<MoviesModel> tvShowList = [];

  @observable
  List<MoviesModel> items = [];

  @observable
  String selectedName = '';

  @observable
  ICacheManager<MoviesModel> cacheManager;

  @observable
  IMoviesService service;
  _MovieViewModelBase({
    required this.service,
    required this.cacheManager,
  }) {
    fetchDatas();
  }

  @observable
  bool showMovie = false; // Varsayılan olarak film detayını göster

  @observable
  bool showTvShow = false; // Varsayılan olarak dizi detayını gösterme

  @observable
  bool isScrolling = true;

  @observable
  bool isHorizantalScRolling = true;

  @action
  void setIsHorizantalScrolling(bool value) {
    isHorizantalScRolling = value;
  }

  @action
  void setIsScrolling(bool value) {
    isScrolling = value;
  }

  @action
  void setIsFavorite() {
    isFavorite = !isFavorite;
  }

  @action
  void toggleDetailType() {
    showMovie = !showMovie; // Kullanıcı her tıklamada gösterilecek veriyi değiştirir
  }

  @action
  void toggleTvShow() {
    showTvShow = !showTvShow;
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> fetchDatas() async {
    await cacheManager.init();

    if (cacheManager.getValues()?.isNotEmpty ?? false) {
      trendMovieList = cacheManager.getValues()!.where((item) => item.media_type == 'movie').toList();
      tvShowList = cacheManager.getValues()!.where((item) => item.media_type == 'tv').toList();
    } else {
      trendMovieList = await service.fetchMovie();
      tvShowList = await service.fetchTvShows();
      await cacheManager.addItems(trendMovieList);
      await cacheManager.addItems(tvShowList);
    }
    changeLoading();
  }

  @action
  Future<void> addItems(List<MoviesModel> items) async {
    await cacheManager.addItems(items);
  }

  @action
  Future<void> removeItem(String key) async {
    await cacheManager.removeItem(key);
  }

  @action
  Future<void> putItem(String key, MoviesModel item) async {
    await cacheManager.putItem(key, item);
  }

  @action
  Future<void> putItems(List<MoviesModel> items) async {
    await cacheManager.putItems(items);
  }

  @action
  Future<void> clearAll() async {
    await cacheManager.clearAll();
  }

  @action
  List<MoviesModel> getValues() {
    return cacheManager.getValues()!;
  }

  @action
  MoviesModel? getItem(String key) {
    return cacheManager.getItem(key);
  }

  @action
  Future<void> changeAppBarColor(Color color) async {
    appBarColor = color;
  }
}
