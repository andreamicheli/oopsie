import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'dart:math';

class Obstacle extends BodyComponent {
  final Sprite sprite;
  final double width;
  final double height;
  final Vector2 spawnPosition;

  Obstacle({
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

    // final spriteComponent = SpriteComponent(
    //     anchor: Anchor.center,
    //     sprite: sprite,
    //     size: Vector2(width, 2),
    //     position: spawnPosition);

    // add(spriteComponent);

    return body;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 255); // Green color
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
        outlinePaint);
  }
}
