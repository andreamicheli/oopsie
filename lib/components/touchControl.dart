import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class TouchControl extends HudButtonComponent with TapCallbacks {
  final bool isLeftSide;
  final VoidCallback onPressedCallback;
  bool isPressed = false;

  TouchControl({
    required this.isLeftSide,
    required this.onPressedCallback,
  }) : super(
          button: RectangleComponent(
            size: Vector2(200, 700),
            position: Vector2.zero(),
            paint: Paint()
              ..color = const Color(0x00000000)
              ..style = PaintingStyle.fill,
          ),
        );

  @override
  bool onTapDown(TapDownEvent event) {
    isPressed = true;
    return true;
  }

  @override
  bool onTapUp(TapUpEvent event) {
    isPressed = false;
    return true;
  }

  @override
  bool onTapCancel(TapCancelEvent event) {
    isPressed = false;
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isPressed) {
      onPressedCallback();
    }
  }
}
