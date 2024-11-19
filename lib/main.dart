import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:ui';
import 'package:forge2d_game/screens/start_screen.dart';
import 'screens/game_screen.dart';
import 'screens/results_screen.dart';
import 'package:get/get.dart';

void main() {
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
      ],
    );
  }
}
