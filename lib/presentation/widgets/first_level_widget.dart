import 'dart:async';
import 'dart:math';

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
    114,
    125,
    127,
    116
  ];

  List<int> food = [];

  String direction = "right";
  bool mouthClosed = false;
  String ghostDirection = "";
  Timer? gameTimer;
  Timer? ghostTimer;
  bool isGameOver = false;
  int endGameScore = 0;
  bool isGameStarted = false;

  int score = 0;
  int ghost = 20;

  void startGame() {
    score = 0;
    ghost = 20;
    food = [];
    player = numberInRow * 15 + 1;
    isGameOver = false;
    direction = "right";
    isGameStarted = true;

    ghostDirection = _getRandomGhostDirection();
    getFood();
    endGameScore = food.length;
    ghostTimer?.cancel();
    gameTimer?.cancel();

    gameTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (isGameOver) {
        gameTimer?.cancel(); // Остановить таймер, если игра закончилась
        return;
      }

      setState(() {
        mouthClosed = !mouthClosed;

        if (food.contains(player)) {
          food.remove(player);
          score++;
        }

        switch (direction) {
          case "left":
            _moveLeft();
            break;
          case "right":
            _moveRight();
            break;
          case "up":
            _moveUp();
            break;
          case "down":
            _moveDown();
            break;
        }

        if (player == ghost) {
          isGameOver = true;
          gameTimer?.cancel();
          ghostTimer?.cancel();
        } else if (score == endGameScore) {
          gameTimer?.cancel();
          ghostTimer?.cancel();
        }
      });
    });

    ghostTimer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      if (isGameOver) {
        ghostTimer?.cancel(); // Остановить таймер, если игра закончилась
        return;
      }

      setState(() {
        _moveGhost(); // Двигаем призрака
      });
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
        if (player - 1 == 88) {
          player = 98;
          food.remove(88);
          score++;
        } else
          player--;
      });
    }
  }

  void _moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        if (player + 1 == 98) {
          player = 88;
          food.remove(98);
          score++;
        } else
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

  void _moveGhost() {
    // Определяем направление к Пакману
    int deltaX = (player % numberInRow) - (ghost % numberInRow);
    int deltaY = (player ~/ numberInRow) - (ghost ~/ numberInRow);

    String ghostDirection;

    if (deltaX.abs() > deltaY.abs()) {
      // Двигаться по оси X
      if (deltaX > 0) {
        ghostDirection = "right";
      } else {
        ghostDirection = "left";
      }
    } else {
      // Двигаться по оси Y
      if (deltaY > 0) {
        ghostDirection = "down";
      } else {
        ghostDirection = "up";
      }
    }

    // Проверка на столкновение с барьером
    int nextPosition = ghost;
    switch (ghostDirection) {
      case "left":
        nextPosition = ghost - 1;
        break;
      case "right":
        nextPosition = ghost + 1;
        break;
      case "up":
        nextPosition = ghost - numberInRow;
        break;
      case "down":
        nextPosition = ghost + numberInRow;
        break;
    }

    if (!barriers.contains(nextPosition)) {
      setState(() {
        ghost = nextPosition; // Двигаемся в сторону Пакмана
      });
    } else {
      // Если столкнулись с барьером, выбираем новое случайное направление
      ghostDirection = _getRandomGhostDirection();
      nextPosition = ghost; // Сброс позиции для нового направления

      switch (ghostDirection) {
        case "left":
          nextPosition = ghost - 1;
          break;
        case "right":
          nextPosition = ghost + 1;
          break;
        case "up":
          nextPosition = ghost - numberInRow;
          break;
        case "down":
          nextPosition = ghost + numberInRow;
          break;
      }

      // Проверка на столкновение с барьером для нового направления
      if (!barriers.contains(nextPosition)) {
        setState(() {
          ghost = nextPosition; // Двигаемся в новом направлении
        });
      }
    }
  }

  String _getRandomGhostDirection() {
    List<String> directions = ["left", "right", "up", "down"];
    return directions[Random().nextInt(directions.length)];
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
          isGameOver && isGameStarted
              ? Expanded(
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
                          onTap: startGame,
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
                )
              : score == endGameScore && isGameStarted
                  ? Expanded(
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
                            SizedBox(
                              height: 15,
                            ),
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
                    )
                  : Expanded(
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
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: numberInRow),
                              itemBuilder: (BuildContext context, int index) {
                                if (mouthClosed && player == index) {
                                  return Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 245, 222, 17),
                                          shape: BoxShape.circle),
                                    ),
                                  );
                                } else if (index == ghost) {
                                  return Image.asset("assets/image/ghost.png");
                                } else if (player == index) {
                                  switch (direction) {
                                    case "left":
                                      return Transform(
                                        transform: Matrix4.rotationY(
                                            pi), // Поворот вокруг оси Y
                                        alignment:
                                            Alignment.center, // Центр вращения
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
                                    child: Text(
                                      index.toString(),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                } else if (food.contains(index) ||
                                    food.isEmpty) {
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
