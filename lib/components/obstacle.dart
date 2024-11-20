import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d_game/components/circle_player.dart';
import 'package:forge2d_game/game.dart';
import 'package:get/get.dart';

import 'ground.dart';

class Obstacle extends BodyComponent with ContactCallbacks {
  final OopsieGame gameRef;
  final Sprite sprite;
  final double width;
  final double height;
  final Vector2 spawnPosition;

  Obstacle({
    required this.gameRef,
    required this.sprite,
    required this.width,
    required this.height,
    required this.spawnPosition,
  });

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(width / 2, height / 2);

    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = spawnPosition;

    final fixtureDef = FixtureDef(shape)
      ..density = 1.0
      ..friction = 0.3
      ..restitution = 0.2; // Bounciness

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    body.userData = this;

    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ground) {
      gameRef.incrementScore();
      removeFromParent(); // Remove the obstacle from the game
    }
    if (other is CirclePlayer) {
      removeFromParent(); // Remove the obstacle from the game
      Get.toNamed("/results");
      gameRef.pauseEngine();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 255); // Purple color
    final outlinePaint = Paint()
      ..color = const Color(0xFF000000) // Black outline
      ..strokeWidth = 0.2
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: width,
        height: height,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: width,
        height: height,
      ),
      outlinePaint,
    );
  }
}
