import 'dart:async';
import 'package:pacman_game/barriers/levels_barriers.dart';

import 'game_state.dart';
import 'ghost.dart';

class GameController {
  late GameState gameState;
  late Ghost ghost;
  final Function updateUI;

  int endGameScore = 0;
  List<int> get barriers => first_level_barriers;

  String direction = "";
  Timer? gameTimer;
  Timer? ghostTimer;

  bool isGameOver = false;
  bool isGameStarted = false;
  bool mouthClosed = false;

  GameController({required this.updateUI}) {
    gameState = GameState(barriers: barriers);
    ghost = Ghost(barriers: barriers, numberInRow: 11);
  }

  void startGame() {
    gameTimer?.cancel();
    ghostTimer?.cancel();

    gameState.reset();
    ghost.reset();

    endGameScore = gameState.food.length;
    direction = "";
    isGameOver = false;
    isGameStarted = true;
    mouthClosed = true;

    ghostTimer = Timer.periodic(Duration(milliseconds: 600), (timer) {
      if (isGameOver) {
        ghostTimer?.cancel(); // Остановить таймер, если игра закончилась
        return;
      }

      ghost.move(gameState.playerPosition);
      updateUI(); // Двигаем призрака
    });

    gameTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (isGameOver) {
        gameTimer?.cancel(); // Остановить таймер, если игра закончилась
        return;
      }

      mouthClosed = !mouthClosed;

      if (gameState.food.contains(gameState.playerPosition)) {
        gameState.food.remove(gameState.playerPosition);
        gameState.score++;
      }

      switch (direction) {
        case "left":
          _moveLeft();
          updateUI();
          break;
        case "right":
          _moveRight();
          updateUI();
          break;
        case "up":
          _moveUp();
          updateUI();
          break;
        case "down":
          _moveDown();
          updateUI();
          break;
        default:
          updateUI();
          break;
      }

      if (gameState.playerPosition == ghost.position) {
        isGameOver = true;
        gameTimer?.cancel();
        ghostTimer?.cancel();
        updateUI();
      } else if (gameState.score == endGameScore) {
        gameTimer?.cancel();
        ghostTimer?.cancel();
        updateUI();
      } // Двигаем призрака
    });
  }

  void _startGhostTimer(Timer? ghostTimer, bool isGameOver) {}

  void _startGameTimer(Timer? gameTimer, bool isGameOver) {}

  void _moveLeft() {
    if (!gameState.barriers.contains(gameState.playerPosition - 1)) {
      if (gameState.playerPosition - 1 == 88) {
        gameState.playerPosition = 98;
        gameState.food.remove(88);
        gameState.score++;
      } else
        gameState.playerPosition--;
    }
  }

  void _moveRight() {
    if (!gameState.barriers.contains(gameState.playerPosition + 1)) {
      if (gameState.playerPosition + 1 == 98) {
        gameState.playerPosition = 88;
        gameState.food.remove(98);
        gameState.score++;
      } else
        gameState.playerPosition++;
    }
  }

  void _moveUp() {
    if (!gameState.barriers
        .contains(gameState.playerPosition - ghost.numberInRow)) {
      gameState.playerPosition -= ghost.numberInRow;
    }
  }

  void _moveDown() {
    if (!gameState.barriers
        .contains(gameState.playerPosition + ghost.numberInRow)) {
      gameState.playerPosition += ghost.numberInRow;
    }
  }
}
