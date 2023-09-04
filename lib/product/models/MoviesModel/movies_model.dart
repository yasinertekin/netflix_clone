import 'package:json_annotation/json_annotation.dart';

part 'movies_model.g.dart';

@JsonSerializable()
class MoviesModel {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? poster_path;
  final String? media_type;
  final List<int>? genreIds;
  final double? popularity;
  final String? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final String? name;

  MoviesModel(
      {this.adult,
      this.backdropPath,
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
}
