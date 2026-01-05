import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:testLast-platformer-07/components/player.dart';
import 'package:testLast-platformer-07/components/obstacle.dart';
import 'package:testLast-platformer-07/components/collectible.dart';
import 'package:testLast-platformer-07/services/analytics_service.dart';
import 'package:testLast-platformer-07/services/ads_service.dart';
import 'package:testLast-platformer-07/services/storage_service.dart';

/// The main game class for the 'testLast-platformer-07' game.
class testLast-platformer-07Game extends FlameGame with TapDetector {
  /// The current game state.
  GameState _gameState = GameState.playing;

  /// The player component.
  late Player _player;

  /// The list of obstacles in the current level.
  final List<Obstacle> _obstacles = [];

  /// The list of collectibles in the current level.
  final List<Collectible> _collectibles = [];

  /// The current score.
  int _score = 0;

  /// The analytics service.
  final AnalyticsService _analyticsService = AnalyticsService();

  /// The ads service.
  final AdsService _adsService = AdsService();

  /// The storage service.
  final StorageService _storageService = StorageService();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the first level
    await _loadLevel(1);
  }

  /// Loads the specified level.
  Future<void> _loadLevel(int levelNumber) async {
    // Load level data from storage or other source
    // Instantiate player, obstacles, and collectibles
    _player = Player();
    _obstacles.addAll([
      Obstacle(position: Vector2(100, 300)),
      Obstacle(position: Vector2(300, 400)),
    ]);
    _collectibles.addAll([
      Collectible(position: Vector2(200, 250)),
      Collectible(position: Vector2(400, 350)),
    ]);

    // Add components to the game world
    add(_player);
    _obstacles.forEach(add);
    _collectibles.forEach(add);

    // Notify analytics service about level start
    _analyticsService.logLevelStart(levelNumber);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update game state based on player and component interactions
    switch (_gameState) {
      case GameState.playing:
        // Update player, obstacles, and collectibles
        _player.update(dt);
        _obstacles.forEach((obstacle) => obstacle.update(dt));
        _collectibles.forEach((collectible) => collectible.update(dt));

        // Check for collisions and update score
        _handleCollisions();
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

  /// Handles collisions between the player, obstacles, and collectibles.
  void _handleCollisions() {
    // Check for player collisions with obstacles and collectibles
    // Update score and game state accordingly
    // Notify analytics service about relevant events
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    // Handle tap input for the player's jump action
    _player.jump();
  }

  /// Pauses the game.
  void pauseGame() {
    _gameState = GameState.paused;
  }

  /// Resumes the game.
  void resumeGame() {
    _gameState = GameState.playing;
  }

  /// Ends the game.
  void gameOver() {
    _gameState = GameState.gameOver;
    // Notify analytics service about game over event
    _analyticsService.logGameOver();
  }

  /// Completes the current level.
  void levelComplete() {
    _gameState = GameState.levelComplete;
    // Notify analytics service about level complete event
    _analyticsService.logLevelComplete();
    // Save player progress and score
    _storageService.savePlayerProgress(_score);
    // Check if next level is locked, and show unlock prompt if necessary
    if (_isLevelLocked(currentLevel + 1)) {
      _adsService.showUnlockPrompt();
    }
  }

  /// Checks if the specified level is locked.
  bool _isLevelLocked(int levelNumber) {
    // Check storage service for locked levels
    return _storageService.isLevelLocked(levelNumber);
  }
}

/// The possible game states.
enum GameState {
  playing,
  paused,
  gameOver,
  levelComplete,
}