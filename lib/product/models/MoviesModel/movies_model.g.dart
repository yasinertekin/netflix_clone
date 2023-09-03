// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesModel _$MoviesModelFromJson(Map<String, dynamic> json) => MoviesModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdropPath'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
      originalTitle: json['originalTitle'] as String?,
      overview: json['overview'] as String?,
      poster_path: json['poster_path'] as String?,
      mediaType: json['mediaType'] as String?,
      genreIds: (json['genreIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      releaseDate: json['releaseDate'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: json['voteCount'] as int?,
    );

Map<String, dynamic> _$MoviesModelToJson(MoviesModel instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdropPath': instance.backdropPath,
      'id': instance.id,
      'title': instance.title,
      'originalLanguage': instance.originalLanguage,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'mediaType': instance.mediaType,
      'genreIds': instance.genreIds,
      'popularity': instance.popularity,
      'releaseDate': instance.releaseDate,
      'video': instance.video,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
    };
