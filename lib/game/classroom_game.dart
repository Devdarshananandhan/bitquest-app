import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassroomGame extends FlameGame with HasKeyboardHandlerComponents {
  late SpriteComponent player;
  final List<SpriteComponent> students = [];
  late TextComponent infoText;
  late TextComponent scoreText;
  void moveLeft() => _movePlayer(Vector2(-10, 0));
  void moveRight() => _movePlayer(Vector2(10, 0));
  void moveUp() => _movePlayer(Vector2(0, -10));
  void moveDown() => _movePlayer(Vector2(0, 10));
  void jump() => _jumpPlayer();
  void resetStudents() => _resetStudents();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load player
    final playerSprite = await loadSprite('player.png');
    player = SpriteComponent(
      sprite: playerSprite,
      size: Vector2(64, 64),
      position: Vector2(100, 300),
    );
    add(player);

    // Info text
    infoText = TextComponent(
      text: 'Use arrow keys to move. Press Space to jump. R to reset.',
      position: Vector2(10, 10),
      textRenderer: TextPaint(style: TextStyle(color: Colors.white)),
    );
    add(infoText);

    // Scoreboard
    scoreText = TextComponent(
      text: 'Students: ${students.length}',
      position: Vector2(10, 40),
      textRenderer: TextPaint(style: TextStyle(color: Colors.yellow, fontSize: 18)),
    );
    add(scoreText);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _movePlayer(Vector2(10, 0));
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _movePlayer(Vector2(-10, 0));
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _movePlayer(Vector2(0, -10));
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _movePlayer(Vector2(0, 10));
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        _jumpPlayer();
      } else if (event.logicalKey == LogicalKeyboardKey.keyR) {
        _resetStudents();
      }
    }

    return KeyEventResult.handled;
  }

  void _movePlayer(Vector2 delta) {
    final newPos = player.position + delta;
    // Screen bounds check
    if (newPos.x >= 0 &&
        newPos.x <= size.x - player.size.x &&
        newPos.y >= 0 &&
        newPos.y <= size.y - player.size.y) {
      player.position = newPos;
    }
  }

  void _jumpPlayer() {
    player.position.sub(Vector2(0, 50));
    // Simple gravity effect (back down after short delay)
    Future.delayed(const Duration(milliseconds: 300), () {
      player.position.add(Vector2(0, 50));
    });
  }

  void _resetStudents() {
    for (final s in students) {
      s.removeFromParent();
    }
    students.clear();
    _updateScore();
  }

  void _updateScore() {
    scoreText.text = 'Students: ${students.length}';
  }
}
