import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:netflix_clone/product/constants/hive_constants.dart';

part 'movies_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.moviTypeId)
class MoviesModel {
  @HiveField(0)
  final bool? adult;
  @HiveField(1)
  final String? backdrop_path;
  @HiveField(2)
  final int? id;
  @HiveField(3)
  final String? title;
  @HiveField(4)
  final String? originalLanguage;
  @HiveField(5)
  final String? originalTitle;
  @HiveField(6)
  final String? overview;
  @HiveField(7)
  final String? poster_path;
  @HiveField(8)
  final String? media_type;
  @HiveField(9)
  final List<int>? genreIds;
  @HiveField(10)
  final double? popularity;
  @HiveField(11)
  final String? releaseDate;
  @HiveField(12)
  final bool? video;
  @HiveField(13)
  final double? voteAverage;
  @HiveField(14)
  final int? voteCount;
  @HiveField(15)
  final String? name;

  MoviesModel(
      {this.adult,
      this.backdrop_path,
      this.id,
      this.name,
      this.title,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.poster_path,
      this.media_type,
      this.genreIds,
      this.popularity,
      this.releaseDate,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return _$MoviesModelFromJson(json);
  }

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'backdrop_path': backdrop_path,
      'id': id,
      'name': name,
      'title': title,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'overview': overview,
      'poster_path': poster_path,
      'media_type': media_type,
      'genreIds': genreIds,
      'popularity': popularity,
      'releaseDate': releaseDate,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }
}
