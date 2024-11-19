import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_kenney_xml/flame_kenney_xml.dart';
import 'package:flutter/services.dart';
import 'package:forge2d_game/components/background.dart';
import 'package:forge2d_game/components/circle_player.dart';
import 'package:forge2d_game/components/ground.dart';
import 'package:forge2d_game/components/touchControl.dart';

class OopsieGame extends Forge2DGame {
  OopsieGame()
      : super(
          gravity: Vector2(0, 10),
          camera: CameraComponent.withFixedResolution(width: 500, height: 700),
          world: Forge2DWorld(), // Explicitly create world
        );

  @override
  void onKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
        case LogicalKeyboardKey.keyA:
          player.moveLeft();
          break;
        case LogicalKeyboardKey.arrowRight:
        case LogicalKeyboardKey.keyD:
          player.moveRight();
          break;
      }
    }
  }

  late final XmlSpriteSheet tiles;
  late final CirclePlayer player;

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('background.jpg');
    final spriteSheets = await Future.wait([
      XmlSpriteSheet.load(
        imagePath: 'spritesheet_tiles.png',
        xmlPath: 'images/spritesheet_tiles.xml',
      ),
    ]);
    tiles = spriteSheets[0];
    // Add the player
    player = CirclePlayer(Vector2(5, 10), radius: 2.0); // Adjust size if needed
    await world.add(Background(sprite: Sprite(backgroundImage)));
    await world.add(player);

    await addGround(); // Add this line

    await add(
      TouchControl(
        isLeftSide: true,
        onPressedCallback: () => player.moveLeft(),
      )..position = Vector2(0, 0),
    );

    await add(
      TouchControl(
        isLeftSide: false,
        onPressedCallback: () => player.moveRight(),
      )..position = Vector2(size.x / 2, 0),
    );

    return super.onLoad();
  }

  Future<void> addGround() {
    // Add from here...
    return world.addAll([
      for (var x = camera.visibleWorldRect.left;
          x < camera.visibleWorldRect.right + groundSize;
          x += groundSize)
        Ground(
          Vector2(x, (camera.visibleWorldRect.height - groundSize) / 2),
          tiles.getSprite('grass.png'),
        ),
    ]);
  } // To here.

  // Handle drag interaction (Touch Device)
  bool isTouchingLeftSide = false;
  bool isTouchingRightSide = false;

  @override
  void update(double dt) {
    super.update(dt);
    if (isTouchingLeftSide) {
      player.moveLeft();
    } else if (isTouchingRightSide) {
      player.moveRight();
    }
  }

  // @override
  // void update(double dt) {
  //   // Placeholder for game update logic.
  // }

  // @override
  // void render(Canvas canvas) {
  //   // Placeholder for game rendering logic.
  // }
}
