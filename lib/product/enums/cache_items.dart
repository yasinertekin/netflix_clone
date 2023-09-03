import 'package:netflix_clone/product/initialize/app_cache.dart';

enum CacheItems {
  token;

  String get read => AppCache.instance.sharedPeferences.getString(name) ?? '';

  Future<bool> write(String value) => AppCache.instance.sharedPeferences.setString(name, value);
}
