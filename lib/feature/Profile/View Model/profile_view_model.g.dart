// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateSelectProfileViewModel
    on _CreateSelectProfileViewModelBase, Store {
  late final _$isLoadingAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isEditAtom =
      Atom(name: '_CreateSelectProfileViewModelBase.isEdit', context: context);

  @override
  bool get isEdit {
    _$isEditAtom.reportRead();
    return super.isEdit;
  }

  @override
  set isEdit(bool value) {
    _$isEditAtom.reportWrite(value, super.isEdit, () {
      super.isEdit = value;
    });
  }

  late final _$selectedPhotoURLAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.selectedPhotoURL',
      context: context);

  @override
  String get selectedPhotoURL {
    _$selectedPhotoURLAtom.reportRead();
    return super.selectedPhotoURL;
  }

  @override
  set selectedPhotoURL(String value) {
    _$selectedPhotoURLAtom.reportWrite(value, super.selectedPhotoURL, () {
      super.selectedPhotoURL = value;
    });
  }

  late final _$selectedUsernameAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.selectedUsername',
      context: context);

  @override
  String get selectedUsername {
    _$selectedUsernameAtom.reportRead();
    return super.selectedUsername;
  }

  @override
  set selectedUsername(String value) {
    _$selectedUsernameAtom.reportWrite(value, super.selectedUsername, () {
      super.selectedUsername = value;
    });
  }

  late final _$profilesAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.profiles', context: context);

  @override
  List<Map<String, dynamic>> get profiles {
    _$profilesAtom.reportRead();
    return super.profiles;
  }

  @override
  set profiles(List<Map<String, dynamic>> value) {
    _$profilesAtom.reportWrite(value, super.profiles, () {
      super.profiles = value;
    });
  }

  late final _$favoriteAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.favorite', context: context);

  @override
  List<MoviesModel> get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(List<MoviesModel> value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$addProfileAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.addProfile',
      context: context);

  @override
  Future<void> addProfile(ProfileModel profileModel) {
    return _$addProfileAsyncAction.run(() => super.addProfile(profileModel));
  }

  late final _$removeProfileAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.removeProfile',
      context: context);

  @override
  Future<void> removeProfile(int index) {
    return _$removeProfileAsyncAction.run(() => super.removeProfile(index));
  }

  late final _$getProfilesAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.getProfiles',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> getProfiles() {
    return _$getProfilesAsyncAction.run(() => super.getProfiles());
  }

  late final _$getCharacterDataListAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.getCharacterDataList',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> getCharacterDataList() {
    return _$getCharacterDataListAsyncAction
        .run(() => super.getCharacterDataList());
  }

  late final _$updateProfileAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.updateProfile',
      context: context);

  @override
  Future<void> updateProfile(int index, ProfileModel profileModel) {
    return _$updateProfileAsyncAction
        .run(() => super.updateProfile(index, profileModel));
  }

  late final _$getProfileDocumentAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.getProfileDocument',
      context: context);

  @override
  Future<DocumentReference<Map<String, dynamic>>> getProfileDocument() {
    return _$getProfileDocumentAsyncAction
        .run(() => super.getProfileDocument());
  }

  late final _$addFavoriteMovieAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.addFavoriteMovie',
      context: context);

  @override
  Future<void> addFavoriteMovie(String uid, MoviesModel movieName) {
    return _$addFavoriteMovieAsyncAction
        .run(() => super.addFavoriteMovie(uid, movieName));
  }

  late final _$chechFavoriteMovieAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.chechFavoriteMovie',
      context: context);

  @override
  Future<void> chechFavoriteMovie(MoviesModel movie) {
    return _$chechFavoriteMovieAsyncAction
        .run(() => super.chechFavoriteMovie(movie));
  }

  late final _$removeFavoriteMovieAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.removeFavoriteMovie',
      context: context);

  @override
  Future<void> removeFavoriteMovie(String uid, MoviesModel movieName) {
    return _$removeFavoriteMovieAsyncAction
        .run(() => super.removeFavoriteMovie(uid, movieName));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isEdit: ${isEdit},
selectedPhotoURL: ${selectedPhotoURL},
selectedUsername: ${selectedUsername},
profiles: ${profiles},
favorite: ${favorite}
    ''';
  }
}
