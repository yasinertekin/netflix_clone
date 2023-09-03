import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  late SharedPreferences sharedPeferences;

  AppCache._();

  static AppCache instance = AppCache._();

  Future<void> setup() async {
    sharedPeferences = await SharedPreferences.getInstance();
  }
}
