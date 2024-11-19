import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_kenney_xml/flame_kenney_xml.dart';
import 'package:forge2d_game/components/background.dart';
import 'package:forge2d_game/components/ground.dart';

class OopsieGame extends Forge2DGame {
  OopsieGame()
      : super(
          gravity: Vector2(0, 10),
          camera: CameraComponent.withFixedResolution(width: 500, height: 700),
        );

  late final XmlSpriteSheet tiles;

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

    await world.add(Background(sprite: Sprite(backgroundImage)));
    await addGround(); // Add this line

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

  // @override
  // void update(double dt) {
  //   // Placeholder for game update logic.
  // }

  // @override
  // void render(Canvas canvas) {
  //   // Placeholder for game rendering logic.
  // }
}
