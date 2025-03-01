import 'dart:async';
import 'dart:math';
import 'package:pacman_game/barriers/levels_barriers.dart';

import 'game_state.dart';
import 'ghost.dart';

class GameController {
  late GameState gameState;
  final List<Ghost> ghosts = [];
  final Function updateUI;

  int endGameScore = 0;
  List<int> barriers;

  String direction = "";
  Timer? gameTimer;
  Timer? ghostTimer;

  bool isGameOver = false;
  bool isGameStarted = false;
  bool mouthClosed = false;

  GameController({
    required this.updateUI,
    required this.barriers,
  }) {
    gameState = GameState(barriers: barriers);
  }

  void startGame(int numberOfGhosts, int ghostsSpeed) {
    gameTimer?.cancel();
    ghostTimer?.cancel();

    gameState.reset();
    ghosts.clear(); // Очистить список призраков перед началом новой игры

    // Инициализация призраков в зависимости от уровня
    for (int i = 0; i < numberOfGhosts; i++) {
      int ghostPosition = generateRandomPosition(barriers, 11);
      ghosts.add(
          Ghost(position: ghostPosition, barriers: barriers, numberInRow: 11));
    }

    endGameScore = gameState.food.length;
    direction = "";
    isGameOver = false;
    isGameStarted = true;
    mouthClosed = true;

    ghostTimer = Timer.periodic(Duration(milliseconds: ghostsSpeed), (timer) {
      if (isGameOver) {
        ghostTimer?.cancel(); // Остановить таймер, если игра закончилась
        return;
      }

      for (var ghost in ghosts) {
        ghost.move(gameState.playerPosition);
      }
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

      for (var ghost in ghosts) {
        if (gameState.playerPosition == ghost.position) {
          isGameOver = true;
          gameTimer?.cancel();
          ghostTimer?.cancel();
          updateUI();
          break; // Выход из цикла, если игра закончилась
        }
      }
      if (gameState.score == endGameScore) {
        gameTimer?.cancel();
        ghostTimer?.cancel();
        updateUI();
      } // Двигаем призрака
    });
  }

  int generateRandomPosition(List<int> ghost_spawns, int numberInRow) {
    Random random = Random();
    int position;

    do {
      position = random.nextInt(numberInRow * 17);
    } while (barriers.contains(position) || position > 87);

    return position;
  }

  void _moveLeft() {
    if (!gameState.barriers.contains(gameState.playerPosition - 1)) {
      if (gameState.playerPosition - 1 == 88) {
        gameState.playerPosition += 10;
        gameState.food.remove(88);
        gameState.score++;
      } else
        gameState.playerPosition--;
    }
  }

  void _moveRight() {
    if (!gameState.barriers.contains(gameState.playerPosition + 1)) {
      if (gameState.playerPosition + 1 == 98) {
        gameState.playerPosition -= 9;
        gameState.food.remove(98);
        gameState.score++;
      } else
        gameState.playerPosition++;
    }
  }

  void _moveUp() {
    if (!gameState.barriers.contains(gameState.playerPosition - 11)) {
      gameState.playerPosition -= 11;
    }
  }

  void _moveDown() {
    if (!gameState.barriers.contains(gameState.playerPosition + 11)) {
      gameState.playerPosition += 11;
    }
  }
}
