import 'package:flutter/material.dart';
import 'package:pacman_game/barriers/levels_barriers.dart';
import 'package:pacman_game/presentation/widgets/level_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondLevelPage extends StatefulWidget {
  const SecondLevelPage({super.key});

  @override
  State<SecondLevelPage> createState() => _SecondLevelPageState();
}

class _SecondLevelPageState extends State<SecondLevelPage> {
  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      levelNumber: "Level 2",
      ghostsCount: 1,
      ghostsSpeed: 550,
      barriers: second_level_barriers,
      onLevelCompleted: () {},
    );
  }
}
