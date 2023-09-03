import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:netflix_clone/product/utility/base/base_firebase_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable with IdModel, BaseFireBaseModel<ProfileModel> {
  final String? username;
  final String? photoUrl;

  ProfileModel({
    this.username,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [username, photoUrl];

  ProfileModel copyWith({
    String? username,
    String? photoUrl,
  }) {
    return ProfileModel(
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  ProfileModel fromJson(Map<String, dynamic> json) {
    return ProfileModel.fromJson(json);
    // TODO: implement fromJson
  }

  @override
  // TODO: implement id
  String? get id => throw UnimplementedError();
}
