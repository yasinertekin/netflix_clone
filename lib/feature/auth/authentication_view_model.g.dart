// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthenticationViewModel on _AuthenticationViewModelBase, Store {
  late final _$isLoginAtom =
      Atom(name: '_AuthenticationViewModelBase.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$fetchUserDetailAsyncAction = AsyncAction(
      '_AuthenticationViewModelBase.fetchUserDetail',
      context: context);

  @override
  Future<void> fetchUserDetail(User? user) {
    return _$fetchUserDetailAsyncAction.run(() => super.fetchUserDetail(user));
  }

  late final _$tokenSaveToCacheAsyncAction = AsyncAction(
      '_AuthenticationViewModelBase.tokenSaveToCache',
      context: context);

  @override
  Future<void> tokenSaveToCache(String token) {
    return _$tokenSaveToCacheAsyncAction
        .run(() => super.tokenSaveToCache(token));
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin}
    ''';
  }
}
