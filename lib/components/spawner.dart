import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'dart:math';

import 'package:forge2d_game/components/obstacle.dart';
import 'package:forge2d_game/game.dart';

class RectangleSpawner extends Component {
  final Forge2DGame game;
  final OopsieGame gameRef;
  final Sprite sprite;
  final double rectangleWidth;
  final double rectangleHeight;
  final double initialSpawnInterval;
  final double intervalIncreaseRate;
  double currentSpawnInterval;
  late Timer _spawnTimer;
  final Random _random = Random();

  RectangleSpawner({
    required this.sprite,
    required this.game,
    required this.gameRef,
    required this.rectangleWidth,
    required this.rectangleHeight,
    this.initialSpawnInterval = 5.0,
    this.intervalIncreaseRate = 0.2, // Increase by 0.2 seconds each spawn
  }) : currentSpawnInterval = initialSpawnInterval {
    _spawnTimer = Timer(
      currentSpawnInterval,
      onTick: _spawnRectangle,
      repeat: true,
    );
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
    final spawnX = _random.nextDouble() * 49.0 - 24.5;
    final spawnY = -35.0;

    final rectangle = Obstacle(
      sprite: sprite,
      width: _random.nextDouble() * 10,
      height: 2,
      spawnPosition: Vector2(spawnX, spawnY),
      gameRef: gameRef,
    );

    game.world.add(rectangle);

    // Increase interval and reset timer
    currentSpawnInterval += intervalIncreaseRate;
    _spawnTimer = Timer(
      currentSpawnInterval,
      onTick: _spawnRectangle,
      repeat: true,
    )..start();
  }
}
