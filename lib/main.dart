import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/classroom_game.dart'; // Import your game class

void main() {
  runApp(const GameWithControls());
}

class GameWithControls extends StatelessWidget {
  const GameWithControls({super.key});

  @override
  Widget build(BuildContext context) {
    final game = ClassroomGame();

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  _controlButton("←", () => game.moveLeft()),
                  const SizedBox(width: 10),
                  _controlButton("→", () => game.moveRight()),
                  const SizedBox(width: 10),
                  _controlButton("↑", () => game.moveUp()),
                  const SizedBox(width: 10),
                  _controlButton("↓", () => game.moveDown()),
                  const SizedBox(width: 10),
                  _controlButton("⤴ Jump", () => game.jump()),
                  const SizedBox(width: 10),
                  _controlButton("Reset", () => game.resetStudents()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.blue,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
