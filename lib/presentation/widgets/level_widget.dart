import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pacman_game/game/game_controller.dart';
import 'package:pacman_game/presentation/widgets/home_widget.dart';
import 'package:pacman_game/presentation/widgets/pixel_widget.dart';
import 'package:pacman_game/presentation/widgets/player_widget.dart';
import 'package:pacman_game/presentation/widgets/player_path_widget.dart';

class LevelWidget extends StatefulWidget {
  final int levelNumber;
  final int ghostsCount;
  final int ghostsSpeed;
  final List<int> barriers;

  const LevelWidget({
    super.key,
    required this.levelNumber,
    required this.ghostsCount,
    required this.ghostsSpeed,
    required this.barriers,
  });

  @override
  State<LevelWidget> createState() => _LevelWidgetState();
}

class _LevelWidgetState extends State<LevelWidget> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = GameController(
      updateUI: updateUI,
      barriers: widget.barriers,
    );
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Обработка нажатия кнопки "Назад"
        if (gameController.isGameStarted) {
          // Если игра началась, остановите ее
          gameController.stopGame();
          return true; // Разрешить выход из виджета
        } else {
          // Если игра не началась, вернитесь на предыдущую страницу
          Navigator.of(context).pop();
          return false; // Запретить выход из виджета
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _levelNumberWidget(widget.levelNumber),
            gameController.isGameOver && gameController.isGameStarted
                ? _buildGameOverWidget(
                    gameController, widget.ghostsCount, widget.ghostsSpeed)
                : gameController.gameState.score ==
                            gameController.endGameScore &&
                        gameController.isGameStarted
                    ? _buildGameWinWidget(context)
                    : _buildGamePlayWidget(gameController),
            _playingField(gameController, context, widget.ghostsCount,
                widget.ghostsSpeed),
          ],
        ),
      ),
    );
  }

  Widget _buildGameWinWidget(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightGreen, Colors.green],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30),
                  child: const Center(
                    child: Text(
                      "You win!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: 130,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 69, 196, 255),
                    Color.fromARGB(255, 0, 96, 175)
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Center(
                    child: Text(
                      "Levels page",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _levelNumberWidget(int levelNumber) {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Text(
      "Level $levelNumber",
      style: AppTextStyles.heading,
    ),
  );
}

Widget _playingField(GameController gameController, BuildContext context,
    int ghostsCount, int ghostsSpeed) {
  return Expanded(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue, // Цвет текста
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Отступы
          textStyle: TextStyle(fontSize: 20), // Размер текста
        ),
        child: Text("Score: ${gameController.gameState.score}"),
      ),
      ElevatedButton(
        onPressed: () {
          // Действие при нажатии на кнопку "Start game"
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Game started!',
              textAlign: TextAlign.center,
            )),
          );
          gameController.startGame(ghostsCount, ghostsSpeed);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 20),
        ),
        child: const Text(
          "Start game",
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ));
}

Widget _buildGameOverWidget(
    GameController gameController, int ghostsCount, int ghostsSpeed) {
  return Expanded(
    flex: 8,
    child: Center(
      child: Container(
        width: 220,
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 243, 126, 117),
              Color.fromARGB(255, 246, 20, 4)
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => gameController.startGame(ghostsCount, ghostsSpeed),
            borderRadius: BorderRadius.circular(30),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You lose!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    "Try again",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildGamePlayWidget(GameController gameController) {
  return Expanded(
    flex: 8,
    child: GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          gameController.direction = "down";
        } else if (details.delta.dy < 0) {
          gameController.direction = "up";
        }
      },
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          gameController.direction = "right";
        } else if (details.delta.dx < 0) {
          gameController.direction = "left";
        }
      },
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 187,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 11),
          itemBuilder: (BuildContext context, int index) {
            if (gameController.gameState.playerPosition == index) {
              if (!gameController.mouthClosed) {
                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 245, 222, 17),
                        shape: BoxShape.circle),
                  ),
                );
              } else {
                switch (gameController.direction) {
                  case "left":
                    return Transform(
                      transform: Matrix4.rotationY(pi), // Поворот вокруг оси Y
                      alignment: Alignment.center, // Центр вращения
                      child: Player(), // Ваш виджет Player
                    );
                  case "right":
                    return Player();
                  case "up":
                    return Transform.rotate(
                      angle: 3 * pi / 2,
                      child: Player(),
                    );
                  case "down":
                    return Transform.rotate(
                      angle: pi / 2,
                      child: Player(),
                    );
                  default:
                    return Player();
                }
              }
            } else if (gameController.ghosts
                .any((ghost) => index == ghost.position)) {
              final ghost = gameController.ghosts
                  .firstWhere((ghost) => index == ghost.position);
              return Image.asset(ghost.imagePath);
            } else if (gameController.barriers.contains(index)) {
              return PixelWidget(
                innerColor: Colors.blue[800],
                outerColor: Colors.blue[900],
                child: Text(index.toString()),
              );
            } else if (gameController.gameState.food.contains(index) ||
                !gameController.isGameStarted) {
              return const PlayerPathWidget(
                innerColor: Colors.yellow,
                outerColor: Colors.black,
              );
            } else {
              return const PlayerPathWidget(
                innerColor: Colors.black,
                outerColor: Colors.black,
              );
            }
          }),
    ),
  );
}
