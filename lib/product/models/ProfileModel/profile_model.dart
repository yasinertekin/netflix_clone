import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:uuid/uuid.dart';

class ProfileModel {
  final String id;
  final String username;
  final String photoURL;
  List<MoviesModel>? favorite;

  ProfileModel({
    String? id,
    required this.username,
    required this.photoURL,
    this.favorite,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {'username': username, 'photoURL': photoURL, 'favorite': favorite, 'id': id};
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      username: map['username'],
      photoURL: map['photoURL'],
      favorite: List<MoviesModel>.from(
        map['favorite']?.map(
          (x) => MoviesModel.fromJson(x),
        ),
      ),
      id: map['id'],
    );
  }
}
