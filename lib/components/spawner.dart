import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'dart:math';

import 'package:forge2d_game/components/obstacle.dart';

class RectangleSpawner extends Component {
  final Forge2DGame game;
  final Sprite sprite;
  final double rectangleWidth;
  final double rectangleHeight;
  final double spawnInterval;
  late Timer _spawnTimer;
  final Random _random = Random();

  RectangleSpawner({
    required this.sprite,
    required this.game,
    required this.rectangleWidth,
    required this.rectangleHeight,
    this.spawnInterval = 5,
  }) {
    _spawnTimer = Timer(spawnInterval, onTick: _spawnRectangle, repeat: true);
  }

  @override
  void onMount() {
    super.onMount();
    _spawnTimer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTimer.update(dt);
  }

  void _spawnRectangle() {
    final spawnX = _random.nextDouble() * 49.0 -
        24.5; // Random x-coordinate between -24.5 and 24.5
    final spawnY = -35.0; // Start above the screen

    final rectangle = Obstacle(
      sprite: sprite,
      width: _random.nextDouble() * 10,
      height: 2,
      spawnPosition: Vector2(spawnX, spawnY),
    );

    game.world.add(rectangle);
  }
}
