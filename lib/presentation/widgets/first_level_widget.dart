import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;

  int player = numberInRow * 15 + 1;

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    10,
    24,
    35,
    46,
    57,
    78,
    79,
    80,
    81,
    70,
    59,
    26,
    37,
    38,
    39,
    28,
    30,
    41,
    52,
    63,
    86,
    85,
    84,
    83,
    72,
    61,
    100,
    101,
    102,
    103,
    105,
    106,
    107,
    108,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    158,
    147,
    148,
    149,
    160,
    114,
    125,
    127,
    116
  ];

  List<int> food = [];

  String direction = "right";
  bool mouthClosed = false;

  int score = 0;

  void startGame() {
    getFood();
    Timer.periodic(Duration(milliseconds: 120), (timer) {
      setState(() {
        mouthClosed = !mouthClosed;
      });

      if (food.contains(player)) {
        food.remove(player);
        score++;
      }

      switch (direction) {
        case "left":
          _moveLeft();
        case "right":
          _moveRight();
        case "up":
          _moveUp();
        case "down":
          _moveDown();
      }
    });
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  void _moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void _moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void _moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void _moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
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
          Expanded(
            flex: 8,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      if (mouthClosed && player == index) {
                        return Padding(
                          padding: EdgeInsets.all(3.5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow, shape: BoxShape.circle),
                          ),
                        );
                      } else if (player == index) {
                        switch (direction) {
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
                            Player();
                        }
                      } else if (barriers.contains(index)) {
                        return PixelWidget(
                          innerColor: Colors.blue[800],
                          outerColor: Colors.blue[900],
                        );
                      } else if (food.contains(index) || food.isEmpty) {
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
          ),
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
                  child: Text("Score: " + score.toString()),
                ),
                ElevatedButton(
                    onPressed: () {
                      // Действие при нажатии на кнопку "Start game"
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                          'Игра началась!',
                          textAlign: TextAlign.center,
                        )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: GestureDetector(
                      child: Text(
                        "Start game",
                        textAlign: TextAlign.center,
                      ),
                      onTap: startGame,
                    )),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
