import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// A collectible item component for a platformer game.
class Collectible extends SpriteComponent with CollisionCallbacks {
  final int scoreValue;
  final AudioPlayer _audioPlayer;

  late final Animation<SpriteAnimation> _animation;

  Collectible({
    required Vector2 position,
    required this.scoreValue,
    required Sprite sprite,
    required this.size,
    required AudioPlayer audioPlayer,
  })  : _audioPlayer = audioPlayer,
        super(position: position, size: size) {
    _animation = SpriteAnimation.spriteList([sprite], stepTime: 0.2, loop: true);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = _animation;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    _collectItem();
  }

  void _collectItem() {
    // Trigger score update, audio, and remove the collectible
    _audioPlayer.play();
    removeFromParent();
  }
}