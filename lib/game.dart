import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_kenney_xml/flame_kenney_xml.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forge2d_game/components/background.dart';
import 'package:forge2d_game/components/circle_player.dart';
import 'package:forge2d_game/components/ground.dart';
import 'package:forge2d_game/components/obstacle.dart';
import 'package:forge2d_game/components/scoreDisplay.dart';
import 'package:forge2d_game/components/spawner.dart';
import 'package:forge2d_game/components/touchControl.dart';
import 'package:forge2d_game/components/wall.dart';
import 'package:forge2d_game/controller.dart';
import 'package:get/get.dart';

class OopsieGame extends Forge2DGame with KeyboardEvents {
  OopsieGame()
      : super(
          gravity: Vector2(0, 10),
          camera: CameraComponent.withFixedResolution(width: 500, height: 700),
          world: Forge2DWorld(), // Explicitly create world
        );

  late final XmlSpriteSheet tiles;
  late final XmlSpriteSheet dirt;
  late final CirclePlayer player;
  double score = 0;
  final levelController = Get.find<LevelController>();
  Timer? _spawnTimer;
  void incrementScore() {
    score += 1;
    print("Score: $score"); // For debugging or replace with UI update
  }

  final Set<LogicalKeyboardKey> _pressedKeys = {};

  @override
  FutureOr<void> onLoad() async {
    final backgroundImages = await Future.wait([
      images.load('level1.jpg'),
      images.load('level2.jpg'),
      images.load('level3.jpg'),
    ]);
    final spriteSheets = await Future.wait([
      XmlSpriteSheet.load(
        imagePath: 'spritesheet_tiles.png',
        xmlPath: 'images/spritesheet_tiles.xml',
      ),
    ]);
    tiles = spriteSheets[0];

    player = CirclePlayer(Vector2(5, 10), radius: 2.0); // Adjust size if needed
    await world.add(Background(
        sprite: Sprite(backgroundImages[levelController.currentLevel.value])));
    await world.add(Wall(
        Vector2(camera.visibleWorldRect.left, camera.visibleWorldRect.bottom),
        camera.visibleWorldRect.height));
    await world.add(Wall(
        Vector2(camera.visibleWorldRect.right, camera.visibleWorldRect.bottom),
        camera.visibleWorldRect.height));
    await world.add(
      RectangleSpawner(
        sprite: tiles.getSprite('sand.png'),
        game: this,
        gameRef: this,
        rectangleWidth: 2, // Width in game units
        rectangleHeight: 1, // Height in game units
      ),
    );
    await world.add(player);
    _spawnTimer?.start();

    await addGround(); // Add this line

    await world.add(ScoreDisplay());

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

    // Check keys in update loop for continuous movement
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyA)) {
      player.moveLeft();
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyD)) {
      player.moveRight();
    }

    // Existing touch controls
    if (isTouchingLeftSide) {
      player.moveLeft();
    } else if (isTouchingRightSide) {
      player.moveRight();
    }

    if (score >= 25) {
      this.pauseEngine();
      Get.toNamed("/next");
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // Update pressed keys set
    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    }
    return KeyEventResult.handled;
  }

  @override
  void onRemove() {
    _spawnTimer?.stop();
    super.onRemove();
  }
}

double getRandomX(Vector2 screenDimensions) {
  final random = math.Random();
  return random.nextDouble() * screenDimensions.x;
}

double getRandomNumberInRange(double max) {
  return max * (0.5 + 0.5 * (Vector2.random().x));
}
