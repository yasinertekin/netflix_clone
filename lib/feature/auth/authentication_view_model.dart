import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:netflix_clone/product/enums/cache_items.dart';
part 'authentication_view_model.g.dart';

// ignore: library_private_types_in_public_api
class AuthenticationViewModel = _AuthenticationViewModelBase with _$AuthenticationViewModel;

abstract class _AuthenticationViewModelBase with Store {
  @action
  Future<void> fetchUserDetail(User? user) async {
    if (user == null) {
      return;
    }
    final token = await user.getIdToken();
    await tokenSaveToCache(token!);
    isLogin = true;
  }

  @action
  Future<void> tokenSaveToCache(String token) async {
    await CacheItems.token.write(token);
  }

  @observable
  bool isLogin = false;
}
