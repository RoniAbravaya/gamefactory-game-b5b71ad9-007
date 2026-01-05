import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// The main menu scene for the platformer game.
class MenuScene extends Component with TapCallbacks {
  /// The title of the game.
  final String gameTitle;

  /// The tagline of the game.
  final String gameTagline;

  /// The play button.
  late final Button playButton;

  /// The level select button.
  late final Button levelSelectButton;

  /// The settings button.
  late final Button settingsButton;

  /// The background animation.
  late final SpriteAnimation backgroundAnimation;

  /// Creates a new instance of the [MenuScene] class.
  MenuScene({
    required this.gameTitle,
    required this.gameTagline,
  }) {
    _createPlayButton();
    _createLevelSelectButton();
    _createSettingsButton();
    _createBackgroundAnimation();
  }

  @override
  void onMount() {
    super.onMount();
    add(backgroundAnimation);
    add(playButton);
    add(levelSelectButton);
    add(settingsButton);
  }

  void _createPlayButton() {
    playButton = Button(
      position: Vector2(size.x / 2, size.y * 0.6),
      size: Vector2(200, 60),
      onPressed: () {
        // Navigate to the game scene
      },
      child: Text(
        'Play',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _createLevelSelectButton() {
    levelSelectButton = Button(
      position: Vector2(size.x / 2, size.y * 0.7),
      size: Vector2(200, 60),
      onPressed: () {
        // Navigate to the level select scene
      },
      child: Text(
        'Level Select',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _createSettingsButton() {
    settingsButton = Button(
      position: Vector2(size.x / 2, size.y * 0.8),
      size: Vector2(200, 60),
      onPressed: () {
        // Navigate to the settings scene
      },
      child: Text(
        'Settings',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _createBackgroundAnimation() {
    final spriteSheet = SpriteSheet(
      image: Images.load('background.png'),
      srcSize: Vector2(100, 100),
    );

    backgroundAnimation = spriteSheet.createAnimation(
      row: 0,
      columns: 4,
      stepTime: 0.2,
    );

    backgroundAnimation.loop = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Render the game title and tagline
    final titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
    final taglineStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
    );

    canvas.drawText(
      Text(gameTitle, style: titleStyle),
      Vector2(size.x / 2 - 100, size.y * 0.2),
    );

    canvas.drawText(
      Text(gameTagline, style: taglineStyle),
      Vector2(size.x / 2 - 100, size.y * 0.3),
    );
  }
}