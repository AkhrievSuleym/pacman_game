import 'package:flutter/material.dart';
import 'package:pacman_game/barriers/levels_barriers.dart';
import 'package:pacman_game/presentation/widgets/level_widget.dart';

class FifthLevelPage extends StatefulWidget {
  const FifthLevelPage({super.key});

  @override
  State<FifthLevelPage> createState() => _FifthLevelPageState();
}

class _FifthLevelPageState extends State<FifthLevelPage> {
  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      levelNumber: 5,
      ghostsCount: 2,
      ghostsSpeed: 450,
      barriers: fourthLevelBarriers,
    );
  }
}
