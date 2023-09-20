import 'dart:io';

import 'package:dio/dio.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

abstract class IMoviesService {
  IMoviesService(this.service);

  Future<List<MoviesModel>> fetchMovie();
  Future<List<MoviesModel>> fetchTvShows();
  Future<List<MoviesModel>> fetchPerson();

  final Dio service;
}

class MoviesService extends IMoviesService with Fetcher {
  MoviesService(Dio service) : super(service);

  @override
  Future<List<MoviesModel>> fetchMovie() async {
    return fetch(ServicePath.TRENDS.rawValue);
  }

  @override
  Future<List<MoviesModel>> fetchTvShows() async {
    return fetch(ServicePath.TVSHOW.rawValue);
  }

  @override
  Future<List<MoviesModel>> fetchPerson() async {
    return fetch(ServicePath.TRENDS_PERSON.rawValue);
  }
}

enum ServicePath { TRENDS, BASEURL, TVSHOW, TRENDS_PERSON }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.TRENDS:
        return 'movie/day?$apiKey';
      case ServicePath.BASEURL:
        return 'https://api.themoviedb.org/3/trending/';
      case ServicePath.TVSHOW:
        return 'tv/day?$apiKey';
      case ServicePath.TRENDS_PERSON:
        return 'person/day?$apiKey';

      default:
        throw Exception('Not Found Service Path');
    }
  }
}

String apiKey = 'api_key=YOURAPIKEY';

mixin Fetcher on IMoviesService {
  Future<List<MoviesModel>> fetch(String path) async {
    final response = await service.get(path);

    if (response.statusCode == HttpStatus.ok) {
      final responseData = response.data['results'];
      if (responseData is List) {
        return responseData.map((e) => MoviesModel.fromJson(e)).toList();
      }
    }
    return [];
  }
}
