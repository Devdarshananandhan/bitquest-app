import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: ClassroomGame()));
}

class ClassroomGame extends FlameGame {
  static const int students = 70;
  static const int columns = 5;
  static const double tileSize = 32;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    const double spacing = 4;
    // final rows = (students / columns).ceil();

    for (int i = 0; i < students; i++) {
      final row = i ~/ columns;
      final col = i % columns;

      final student = RectangleComponent(
        size: Vector2(tileSize, tileSize),
        position: Vector2(
          col * (tileSize + spacing) + 20,
          row * (tileSize + spacing) + 20,
        ),
        paint: Paint()..color = Colors.greenAccent,
      );

      final label = TextComponent(
        text: '${i + 1}',
        position: student.position + Vector2(5, 8),
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      );

      add(student);
      add(label);
    }
  }
}
