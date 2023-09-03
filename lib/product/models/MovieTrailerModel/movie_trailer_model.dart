// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:netflix_clone/product/utility/base/base_firebase_model.dart';

part 'movie_trailer_model.g.dart';

@JsonSerializable()
class MovieTrailerModel extends Equatable with IdModel, BaseFireBaseModel<MovieTrailerModel> {
  String? trailer;

  MovieTrailerModel({this.trailer});

  MovieTrailerModel.fromJson(Map<String, dynamic> json) {
    trailer = json['trailer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trailer'] = trailer;
    return data;
  }

  @override
  MovieTrailerModel fromJson(Map<String, dynamic> json) {
    return MovieTrailerModel.fromJson(json);
  }

  @override
  // TODO: implement id
  String? get id => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => [trailer];
}
