import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forge2d_game/controller.dart';
import 'package:forge2d_game/screens/next_screen.dart';
import 'dart:ui';
import 'package:forge2d_game/screens/start_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/game_screen.dart';
import 'screens/results_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.lazyPut<LevelController>(() => LevelController());
  runApp(OopsieApp());
}

class OopsieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Oopsie',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/start',
      getPages: [
        GetPage(name: "/start", page: () => StartScreen()),
        GetPage(name: "/game", page: () => GameScreen()),
        GetPage(name: "/results", page: () => ResultsScreen()),
        GetPage(name: "/next", page: () => NextScreen()),
      ],
    );
  }
}
