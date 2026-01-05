import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

/// The player character in the platformer game.
class Player extends SpriteAnimationComponent with KeyboardEvents, CollisionCallbacks {
  /// The player's current horizontal velocity.
  double velocityX = 0;

  /// The player's current vertical velocity.
  double velocityY = 0;

  /// The player's maximum horizontal speed.
  double maxHorizontalSpeed = 200;

  /// The player's jump force.
  double jumpForce = -500;

  /// The player's current health.
  int health = 3;

  /// The player's current score.
  int score = 0;

  Player({
    required Vector2 position,
    required SpriteAnimation idleAnimation,
    required SpriteAnimation walkingAnimation,
    required SpriteAnimation jumpingAnimation,
  }) : super(
          position: position,
          size: Vector2.all(50),
          animation: idleAnimation,
        );

  @override
  void onMount() {
    super.onMount();
    // Add collision detection
    addCollisionBoxComponent();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply horizontal movement
    velocityX = 0;
    if (isPressed(LogicalKeyboardKey.arrowLeft)) {
      velocityX = -maxHorizontalSpeed;
    } else if (isPressed(LogicalKeyboardKey.arrowRight)) {
      velocityX = maxHorizontalSpeed;
    }
    x += velocityX * dt;

    // Apply gravity and jumping
    velocityY += 1000 * dt;
    if (isPressed(LogicalKeyboardKey.space) && velocityY >= 0) {
      velocityY = jumpForce;
    }
    y += velocityY * dt;

    // Update animation based on player state
    if (velocityX != 0) {
      animation = walkingAnimation;
    } else if (velocityY != 0) {
      animation = jumpingAnimation;
    } else {
      animation = idleAnimation;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // Handle collisions with other game objects
    if (other is Obstacle) {
      // Reduce player health or handle other collision logic
      health--;
    }
  }

  /// Increase the player's score by the given amount.
  void increaseScore(int amount) {
    score += amount;
  }
}