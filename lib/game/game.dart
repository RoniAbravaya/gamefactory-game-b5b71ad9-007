import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:testLast-platformer-07/models/level_config.dart';
import 'package:testLast-platformer-07/services/analytics_service.dart';
import 'package:testLast-platformer-07/controllers/game_controller.dart';

/// The main FlameGame class for the 'testLast-platformer-07' game.
class testLast_platformer_07Game extends FlameGame with TapDetector {
  /// The current game state.
  GameState _gameState = GameState.playing;

  /// The player's score.
  int _score = 0;

  /// The player's remaining lives.
  int _lives = 3;

  /// The level configuration.
  LevelConfig _levelConfig;

  /// The game controller.
  GameController _gameController;

  /// The analytics service.
  AnalyticsService _analyticsService;

  /// Initializes the game.
  testLast_platformer_07Game({
    required this._levelConfig,
    required this._gameController,
    required this._analyticsService,
  }) {
    camera.viewport = FixedResolutionViewport(Vector2(720, 1280));
    camera.followComponent(_gameController.player);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadLevel();
    _gameController.initialize(this);
  }

  /// Loads the current level.
  void _loadLevel() {
    // Load level components from _levelConfig
    // Add player, platforms, enemies, etc. to the game world
  }

  /// Handles a tap input.
  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (_gameState == GameState.playing) {
      _gameController.handleTap();
    }
  }

  /// Updates the game state.
  @override
  void update(double dt) {
    super.update(dt);
    switch (_gameState) {
      case GameState.playing:
        _gameController.update(dt);
        break;
      case GameState.paused:
        // Pause game logic
        break;
      case GameState.gameOver:
        // Handle game over logic
        break;
      case GameState.levelComplete:
        // Handle level complete logic
        break;
    }
  }

  /// Handles a collision event.
  void _handleCollision(
    Component collidingComponent,
    Component collidedComponent,
  ) {
    try {
      _gameController.handleCollision(collidingComponent, collidedComponent);
    } catch (e) {
      // Handle collision error gracefully
      print('Collision error: $e');
    }
  }

  /// Handles a game over event.
  void _handleGameOver() {
    _gameState = GameState.gameOver;
    _analyticsService.logEvent('level_fail');
    // Show game over UI, reset game, etc.
  }

  /// Handles a level complete event.
  void _handleLevelComplete() {
    _gameState = GameState.levelComplete;
    _analyticsService.logEvent('level_complete');
    // Show level complete UI, unlock next level, etc.
  }

  /// Handles a player life lost event.
  void _handleLifeLost() {
    _lives--;
    if (_lives <= 0) {
      _handleGameOver();
    } else {
      // Reset player position, show UI, etc.
    }
  }

  /// Handles a score update event.
  void _handleScoreUpdate(int score) {
    _score = score;
    // Update UI, trigger achievements, etc.
  }
}

/// The game state enum.
enum GameState {
  playing,
  paused,
  gameOver,
  levelComplete,
}