import 'package:hive/hive.dart';
import 'package:netflix_clone/product/constants/hive_constants.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

abstract class ICacheManager<T> {
  final String key;

  Box<MoviesModel>? _box;

  ICacheManager(this.key);

  Future<void> init() async {
    saveMovieAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox(key);
    }
  }

  void saveMovieAdapters();

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);

  T? getItem(String key);
  List<T>? getValues();

  Future<void> putItem(String key, T item);
  Future<void> removeItem(String key);
}

class MovieCacheManager extends ICacheManager<MoviesModel> {
  MovieCacheManager(super.key);

  @override
  Future<void> addItems(List<MoviesModel> items) async {
    await _box?.addAll(items);
  }

  @override
  MoviesModel? getItem(String key) {
    return _box?.get(key);
  }

  @override
  List<MoviesModel>? getValues() {
    return _box?.values.toList();
  }

  @override
  Future<void> putItem(String key, MoviesModel item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> putItems(List<MoviesModel> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  @override
  Future<void> removeItem(String key) async {
    await _box?.delete(key);
  }

  @override
  void saveMovieAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.moviTypeId)) {
      Hive.registerAdapter(MoviesModelAdapter());
    }
  }
}
