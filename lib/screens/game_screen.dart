import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';

class GameScreen extends StatelessWidget {
  final OopsieGame _game = OopsieGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
      ),
      body: GameWidget(game: _game),
    );
  }
}
