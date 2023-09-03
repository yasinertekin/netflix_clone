import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/feature/OnBoard/onboard_screen.dart';
import 'package:netflix_clone/feature/Profile/create_select_profile_screen.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    // Firebase Authentication durumunu kontrol et
    User? user = FirebaseAuth.instance.currentUser;

    // Kullanıcı oturum açmışsa home ekranını başlat, aksi takdirde onboard veya auth ekranını başlat
    if (user != null) {
      return const CreateSelectProfileScreen();
    } else {
      return const OnBoardScreen(); // veya AuthScreen();
    }
  }
}
