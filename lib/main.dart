import 'package:flutter/material.dart';
import 'package:netflix_clone/product/Starter/app_starter.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/initialize/app_start_initialize.dart';
import 'package:netflix_clone/product/theme/app_theme.dart';

Future<void> main() async {
  await AppStartInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstans.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context).theme,
      home: const AppStarter(),
    );
  }
}
