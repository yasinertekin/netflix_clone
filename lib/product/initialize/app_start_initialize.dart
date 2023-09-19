import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:netflix_clone/firebase_options.dart';
import 'package:netflix_clone/product/initialize/app_cache.dart';

@immutable
class AppStartInit {
  const AppStartInit._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized(); //flutter bileşenlerini kullanmadan önce gerekli başlatmayı yapmış oluruz
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    await AppCache.instance.setup();
    await Hive.initFlutter();
  }
}
