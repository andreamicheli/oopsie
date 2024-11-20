import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:forge2d_game/game.dart';

final regular = TextPaint(
    style: TextStyle(
  color: Colors.white,
  fontSize: 7.0,
  fontFamily: 'PressStart2P',
));

class ScoreDisplay extends TextComponent with HasGameReference<OopsieGame> {
  ScoreDisplay()
      : super(
          text: '0',
          position: Vector2(0, -25), // Top-left corner
          textRenderer: regular,
          anchor: Anchor.center,
          priority: 1, // Ensure it renders above other components
        );

  @override
  void update(double dt) {
    text = '${game.score}';
    super.update(dt);
  }
}
