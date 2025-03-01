import 'package:flutter/material.dart';
import 'package:pacman_game/barriers/levels_barriers.dart';
import 'package:pacman_game/presentation/widgets/level_widget.dart';

class FirstLevelPage extends StatefulWidget {
  const FirstLevelPage({super.key});

  @override
  State<FirstLevelPage> createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      levelNumber: 1,
      ghostsCount: 1,
      ghostsSpeed: 600,
      barriers: firstLevelBarriers,
    );
  }
}
