import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-platformer-07/player.dart';

/// Represents an obstacle in the platformer game.
class Obstacle extends PositionComponent with CollisionCallbacks {
  final Sprite _sprite;
  final double _speed;
  final double _damage;

  /// Creates a new instance of the Obstacle component.
  ///
  /// [position] the initial position of the obstacle.
  /// [size] the size of the obstacle.
  /// [sprite] the sprite to be used for the visual representation.
  /// [speed] the speed at which the obstacle moves.
  /// [damage] the amount of damage the obstacle deals to the player on collision.
  Obstacle({
    required Vector2 position,
    required Vector2 size,
    required Sprite sprite,
    required double speed,
    required double damage,
  })  : _sprite = sprite,
        _speed = speed,
        _damage = damage,
        super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxShape.rectangle(size));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= _speed * dt;

    // Respawn the obstacle if it goes off-screen
    if (position.x < -size.x) {
      position.x = size.x + 100;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      other.takeDamage(_damage);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.render(canvas, position: position, size: size);
  }
}