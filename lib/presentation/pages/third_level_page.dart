import 'package:flutter/material.dart';
import 'package:pacman_game/barriers/levels_barriers.dart';
import 'package:pacman_game/presentation/widgets/level_widget.dart';

class ThirdLevelPage extends StatefulWidget {
  const ThirdLevelPage({super.key});

  @override
  State<ThirdLevelPage> createState() => _ThirdLevelPageState();
}

class _ThirdLevelPageState extends State<ThirdLevelPage> {
  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      levelNumber: 3,
      ghostsCount: 2,
      ghostsSpeed: 500,
      barriers: thirdLevelBarriers,
    );
  }
}
