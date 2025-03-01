import 'dart:math';

class Ghost {
  int position;
  final List<int> barriers;
  final int numberInRow;

  Ghost({
    required this.position,
    required this.barriers,
    required this.numberInRow,
  });

  void move(int playerPosition) {
    // Определяем направление к Пакману
    int deltaX = (playerPosition % numberInRow) - (position % numberInRow);
    int deltaY = (playerPosition ~/ numberInRow) - (position ~/ numberInRow);

    String ghostDirection;

    if (deltaX.abs() > deltaY.abs()) {
      // Двигаться по оси X
      ghostDirection = deltaX > 0 ? "right" : "left";
    } else {
      // Двигаться по оси Y
      ghostDirection = deltaY > 0 ? "down" : "up";
    }

    // Проверка на столкновение с барьером
    int nextPosition = position;
    switch (ghostDirection) {
      case "left":
        nextPosition = position - 1;
        break;
      case "right":
        nextPosition = position + 1;
        break;
      case "up":
        nextPosition = position - numberInRow;
        break;
      case "down":
        nextPosition = position + numberInRow;
        break;
    }

    if (!barriers.contains(nextPosition)) {
      position = nextPosition; // Двигаемся в сторону Пакмана
    } else {
      // Если столкнулись с барьером, выбираем новое случайное направление
      _moveRandomly();
    }
  }

  void _moveRandomly() {
    String randomDirection = _getRandomGhostDirection();
    int nextPosition = position;

    switch (randomDirection) {
      case "left":
        nextPosition = position - 1;
        break;
      case "right":
        nextPosition = position + 1;
        break;
      case "up":
        nextPosition = position - numberInRow;
        break;
      case "down":
        nextPosition = position + numberInRow;
        break;
    }

    // Проверка на столкновение с барьером для нового направления
    if (!barriers.contains(nextPosition)) {
      position = nextPosition; // Двигаемся в новом направлении
    }
  }

  String _getRandomGhostDirection() {
    List<String> directions = ["left", "right", "up", "down"];
    return directions[Random().nextInt(directions.length)];
  }
}
