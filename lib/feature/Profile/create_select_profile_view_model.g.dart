// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_select_profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateSelectProfileViewModel
    on _CreateSelectProfileViewModelBase, Store {
  late final _$newUsernameAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.newUsername', context: context);

  @override
  String get newUsername {
    _$newUsernameAtom.reportRead();
    return super.newUsername;
  }

  @override
  set newUsername(String value) {
    _$newUsernameAtom.reportWrite(value, super.newUsername, () {
      super.newUsername = value;
    });
  }

  late final _$newPhotoURLAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.newPhotoURL', context: context);

  @override
  String get newPhotoURL {
    _$newPhotoURLAtom.reportRead();
    return super.newPhotoURL;
  }

  @override
  set newPhotoURL(String value) {
    _$newPhotoURLAtom.reportWrite(value, super.newPhotoURL, () {
      super.newPhotoURL = value;
    });
  }

  late final _$docSnapshotAtom = Atom(
      name: '_CreateSelectProfileViewModelBase.docSnapshot', context: context);

  @override
  dynamic get docSnapshot {
    _$docSnapshotAtom.reportRead();
    return super.docSnapshot;
  }

  @override
  set docSnapshot(dynamic value) {
    _$docSnapshotAtom.reportWrite(value, super.docSnapshot, () {
      super.docSnapshot = value;
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

  late final _$getCharacterDataListAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.getCharacterDataList',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> getCharacterDataList() {
    return _$getCharacterDataListAsyncAction
        .run(() => super.getCharacterDataList());
  }

  late final _$getProfilesAsyncAction = AsyncAction(
      '_CreateSelectProfileViewModelBase.getProfiles',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> getProfiles() {
    return _$getProfilesAsyncAction.run(() => super.getProfiles());
  }

  late final _$_CreateSelectProfileViewModelBaseActionController =
      ActionController(
          name: '_CreateSelectProfileViewModelBase', context: context);

  @override
  void removeProfile(int index) {
    final _$actionInfo = _$_CreateSelectProfileViewModelBaseActionController
        .startAction(name: '_CreateSelectProfileViewModelBase.removeProfile');
    try {
      return super.removeProfile(index);
    } finally {
      _$_CreateSelectProfileViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  Future<void> addProfile(String username, String photoURL) {
    final _$actionInfo = _$_CreateSelectProfileViewModelBaseActionController
        .startAction(name: '_CreateSelectProfileViewModelBase.addProfile');
    try {
      return super.addProfile(username, photoURL);
    } finally {
      _$_CreateSelectProfileViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newUsername: ${newUsername},
newPhotoURL: ${newPhotoURL},
docSnapshot: ${docSnapshot},
profiles: ${profiles}
    ''';
  }
}
