import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:netflix_clone/feature/services/firebase_service.dart';

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

  @action
  Future<void> addProfile(String username, String photoURL) async {
    await _profileService.addProfile(username, photoURL);
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
  Future<void> updateProfile(int index, String username, String? photoURL) async {
    await _profileService.updateProfile(index, username, photoURL);
  }

  @action
  Future<DocumentReference<Map<String, dynamic>>> getProfileDocument() async {
    return await _profileService.getProfileDocument();
  }

  void setIsEditing() {
    isEdit = !isEdit;
  }
}
