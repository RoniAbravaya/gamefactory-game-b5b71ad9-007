import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// The main game scene that handles level loading, player and obstacle spawning,
/// game loop logic, score display, and pause/resume functionality.
class GameScene extends Component with HasGameRef {
  /// The player component.
  late Player player;

  /// The list of obstacles in the current level.
  final List<Obstacle> _obstacles = [];

  /// The list of collectibles in the current level.
  final List<Collectible> _collectibles = [];

  /// The current score.
  int _score = 0;

  /// Whether the game is currently paused.
  bool _isPaused = false;

  @override
  Future<void> onLoad() async {
    /// Load the current level and set up the game scene.
    await _loadLevel();
    _spawnPlayer();
    _spawnObstacles();
    _spawnCollectibles();
  }

  @override
  void update(double dt) {
    super.update(dt);

    /// Update the game logic if the game is not paused.
    if (!_isPaused) {
      _handlePlayerMovement();
      _handleCollisions();
      _updateScore();
      _checkWinCondition();
      _checkLoseCondition();
    }
  }

  /// Loads the current level and sets up the game scene.
  Future<void> _loadLevel() async {
    // Load level data from a file or database
    // and initialize the game scene accordingly
  }

  /// Spawns the player in the game scene.
  void _spawnPlayer() {
    player = Player(position: Vector2(50, gameRef.size.y - 100));
    add(player);
  }

  /// Spawns the obstacles in the game scene.
  void _spawnObstacles() {
    // Spawn obstacles based on the current level data
    for (final obstacleData in _levelData.obstacles) {
      final obstacle = Obstacle(position: obstacleData.position);
      _obstacles.add(obstacle);
      add(obstacle);
    }
  }

  /// Spawns the collectibles in the game scene.
  void _spawnCollectibles() {
    // Spawn collectibles based on the current level data
    for (final collectibleData in _levelData.collectibles) {
      final collectible = Collectible(position: collectibleData.position);
      _collectibles.add(collectible);
      add(collectible);
    }
  }

  /// Handles the player's movement based on user input.
  void _handlePlayerMovement() {
    // Update the player's position based on user input
    player.update(gameRef.input);
  }

  /// Handles collisions between the player, obstacles, and collectibles.
  void _handleCollisions() {
    // Check for collisions between the player and obstacles/collectibles
    // and update the game state accordingly
    for (final obstacle in _obstacles) {
      if (player.isColliding(obstacle)) {
        _handleLoseCondition();
      }
    }

    for (final collectible in _collectibles) {
      if (player.isColliding(collectible)) {
        _collectScore(collectible);
        _collectibles.remove(collectible);
        remove(collectible);
      }
    }
  }

  /// Updates the player's score based on collected items.
  void _updateScore() {
    // Update the player's score based on collected items
    // and display the updated score on the UI
  }

  /// Checks if the player has won the current level.
  void _checkWinCondition() {
    // Check if the player has reached the goal or completed the level
    // and handle the win condition accordingly
  }

  /// Checks if the player has lost the current level.
  void _handleLoseCondition() {
    // Check if the player has fallen or collided with an obstacle
    // and handle the lose condition accordingly
  }

  /// Collects a collectible and updates the player's score.
  void _collectScore(Collectible collectible) {
    // Update the player's score based on the collected item
    _score += collectible.value;
  }

  /// Pauses the game.
  void pauseGame() {
    _isPaused = true;
    // Pause the game logic and update the UI accordingly
  }

  /// Resumes the game.
  void resumeGame() {
    _isPaused = false;
    // Resume the game logic and update the UI accordingly
  }
}