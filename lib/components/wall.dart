import 'package:flame_forge2d/flame_forge2d.dart';

import 'body_component_with_user_data.dart'; // Add this import

class Wall extends BodyComponentWithUserData {
  Wall(Vector2 position, double gameHeight)
      : super(
          renderBody: false,
          bodyDef: BodyDef()
            ..position = position
            ..type = BodyType.static,
          fixtureDefs: [
            FixtureDef(
              PolygonShape()..setAsBoxXY(1.0, gameHeight),
              friction: 0.3,
            )
          ],
        );
}
