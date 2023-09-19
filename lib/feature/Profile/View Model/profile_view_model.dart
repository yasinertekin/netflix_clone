import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view.dart';
import 'package:netflix_clone/feature/services/firebase_service.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';

part 'profile_view_model.g.dart';

class CreateSelectProfileViewModel = _CreateSelectProfileViewModelBase with _$CreateSelectProfileViewModel;

abstract class _CreateSelectProfileViewModelBase with Store {
  final ProfileServiceBase _profileService = FirebaseProfileService();

  @observable
  bool isLoading = false;

  @observable
  bool isEdit = false;

  @observable
  String selectedPhotoURL = '';

  @observable
  String selectedUsername = '';

  @observable
  List<Map<String, dynamic>> profiles = [];

  @observable
  List<MoviesModel> favorite = [];

  @action
  Future<void> addProfile(ProfileModel profileModel) async {
    await _profileService.addProfile(
      profileModel,
    );
  }

  @action
  Future<void> removeProfile(int index) async {
    await _profileService.removeProfile(index);
  }

  @action
  Future<List<Map<String, dynamic>>> getProfiles() async {
    return await _profileService.getProfiles();
  }

  @action
  Future<List<Map<String, dynamic>>> getCharacterDataList() async {
    return await _profileService.getCharacterDataList();
  }

  @action
  Future<void> updateProfile(int index, ProfileModel profileModel) async {
    await _profileService.updateProfile(index, profileModel);
  }

  @action
  Future<DocumentReference<Map<String, dynamic>>> getProfileDocument() async {
    return await _profileService.getProfileDocument();
  }

  void setIsEditing() {
    isEdit = !isEdit;
  }

  @action
  Future<void> addFavoriteMovie(String uid, MoviesModel movieName) async {
    await _profileService.addFavoriteMovie(
      uid,
      movieName,
    );
    homeViewModel.setIsFavorite();
  }

  @action
  Future<void> chechFavoriteMovie(MoviesModel movie) async {
    // Eğer favori film zaten listede yoksa, ekleyin
    if (!favorite.contains(movie)) {
      favorite.add(movie);
    } else {
      favorite.remove(movie);
      removeFavoriteMovie(selectedUsername, movie);
    }
  }

  @action
  Future<void> removeFavoriteMovie(String uid, MoviesModel movieName) async {
    await _profileService.removeFavoriteMovie(
      uid,
      movieName,
    );
    homeViewModel.setIsFavorite();
  }
}
