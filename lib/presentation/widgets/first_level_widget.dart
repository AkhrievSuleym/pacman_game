// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pacman_game/game/game_controller.dart';
import 'package:pacman_game/presentation/widgets/home_widget.dart';
import 'package:pacman_game/presentation/widgets/pixel_widget.dart';
import 'package:pacman_game/presentation/widgets/player.dart';
import 'package:pacman_game/presentation/widgets/player_path_widget.dart';

class FirstLevelWidget extends StatefulWidget {
  const FirstLevelWidget({super.key});

  @override
  State<FirstLevelWidget> createState() => _FirstLevelWidgetState();
}

class _FirstLevelWidgetState extends State<FirstLevelWidget> {
  late GameController gameController;
  Logger logger = Logger();
  bool hasPrinted = false;

  @override
  void initState() {
    super.initState();
    gameController = GameController(updateUI: updateUI);
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Level 1",
              style: AppTextStyles.heading,
            ),
          ),
          gameController.isGameOver && gameController.isGameStarted
              ? _buildGameOverWidget(gameController)
              : gameController.gameState.score == gameController.endGameScore &&
                      gameController.isGameStarted
                  ? _buildGameWinWidget(context)
                  : _buildGamePlayWidget(gameController),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Цвет текста
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Отступы
                    textStyle: TextStyle(fontSize: 20), // Размер текста
                  ),
                  child: Text(
                      "Score: " + gameController.gameState.score.toString()),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Действие при нажатии на кнопку "Start game"
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        'Game started!',
                        textAlign: TextAlign.center,
                      )),
                    );
                    gameController.startGame();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text(
                    "Start game",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

Widget _buildGameOverWidget(GameController gameController) {
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
            onTap: gameController.startGame,
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
                onTap: () => Navigator.pop(context),
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
      child: Container(
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 187,
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
            itemBuilder: (BuildContext context, int index) {
              if (gameController.gameState.playerPosition == index) {
                if (!gameController.mouthClosed) {
                  return Padding(
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 222, 17),
                          shape: BoxShape.circle),
                    ),
                  );
                } else {
                  switch (gameController.direction) {
                    case "left":
                      return Transform(
                        transform:
                            Matrix4.rotationY(pi), // Поворот вокруг оси Y
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
              } else if (index == gameController.ghost.position) {
                return Image.asset("assets/image/ghost.png");
              } else if (gameController.barriers.contains(index)) {
                return PixelWidget(
                  innerColor: Colors.blue[800],
                  outerColor: Colors.blue[900],
                );
              } else if (gameController.gameState.food.contains(index) ||
                  !gameController.isGameStarted) {
                return PlayerPathWidget(
                  innerColor: Colors.yellow,
                  outerColor: Colors.black,
                );
              } else
                return PlayerPathWidget(
                  innerColor: Colors.black,
                  outerColor: Colors.black,
                );
            }),
      ),
    ),
  );
}
