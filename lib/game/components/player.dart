import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-platformer-07/game_objects/obstacle.dart';
import 'package:testLast-platformer-07/game_objects/collectable.dart';

/// The player character in the platformer game.
class Player extends SpriteAnimationComponent with HasHitboxes, Collidable {
  static const double _maxHealth = 100.0;
  static const double _invulnerabilityDuration = 1.0; // in seconds

  double _health = _maxHealth;
  double _invulnerabilityTimer = 0.0;
  bool _isInvulnerable = false;

  /// Creates a new instance of the Player component.
  Player({
    required Vector2 position,
    required SpriteAnimation idleAnimation,
    required SpriteAnimation runAnimation,
    required SpriteAnimation jumpAnimation,
    required SpriteAnimation hurtAnimation,
  }) : super(
          position: position,
          size: Vector2.all(32.0),
          animation: idleAnimation,
        ) {
    addHitbox(HitboxCircle(radius: 12.0));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isInvulnerable) {
      _invulnerabilityTimer -= dt;
      if (_invulnerabilityTimer <= 0.0) {
        _isInvulnerable = false;
      }
    }
  }

  /// Handles player movement based on user input.
  void move(Vector2 direction) {
    if (direction.x > 0) {
      animation = runAnimation;
      flipHorizontally();
    } else if (direction.x < 0) {
      animation = runAnimation;
      flipHorizontally(shouldFlip: false);
    } else {
      animation = idleAnimation;
    }

    position.add(direction * 200 * dt);
  }

  /// Handles player jumping.
  void jump() {
    animation = jumpAnimation;
    velocity.y = -500;
  }

  /// Handles player taking damage.
  void takeDamage(double amount) {
    if (!_isInvulnerable) {
      _health -= amount;
      _isInvulnerable = true;
      _invulnerabilityTimer = _invulnerabilityDuration;
      animation = hurtAnimation;
    }
  }

  /// Checks if the player is dead.
  bool get isDead => _health <= 0;

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    if (other is Obstacle) {
      // Handle collision with obstacles
    } else if (other is Collectable) {
      // Handle collision with collectibles
      other.collect();
    }
  }
}