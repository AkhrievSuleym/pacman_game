class GameState {
  int playerPosition;
  int score;
  List<int> barriers;
  List<int> food = [];

  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;

  GameState({
    this.playerPosition = 166,
    this.score = 0,
    required this.barriers,
  });

  void reset() {
    food = [];
    playerPosition = numberInRow * 15 + 1;
    score = 0;
    getFood();
    // Заполнить едой
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }
}
