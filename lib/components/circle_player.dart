import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';

class CirclePlayer extends BodyComponent {
  final Vector2 initialPosition;
  final double radius;
  final double moveSpeed = 8.0; // Increased for more noticeable movement
  final double maxHorizontalVelocity = 15.0; // Increased max speed

  CirclePlayer(this.initialPosition, {this.radius = 1.5}); // Default radius

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.2
      ..density = 1.0
      ..friction = 0.5;
    final bodyDef = BodyDef(
      position: initialPosition,
      type: BodyType.dynamic,
      fixedRotation: true,
      linearDamping: 0.5, // Reduced damping for smoother movement
      bullet: true,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = const Color(0xFF42A5F5) // Cool blue color
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF000000) // Black outline
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Vector2.zero().toOffset(), radius, paint);
    canvas.drawCircle(Vector2.zero().toOffset(), radius, outlinePaint);
  }

  void moveLeft() {
    final velocity = body.linearVelocity;
    if (velocity.x > -maxHorizontalVelocity) {
      body.applyLinearImpulse(Vector2(-moveSpeed, 0));
    }
  }

  void moveRight() {
    final velocity = body.linearVelocity;
    if (velocity.x < maxHorizontalVelocity) {
      body.applyLinearImpulse(Vector2(moveSpeed, 0));
    }
  }
}
