import 'package:flutter/material.dart';
import 'package:pacman_game/barriers/levels_barriers.dart';
import 'package:pacman_game/presentation/widgets/level_widget.dart';

class FourthLevelPage extends StatefulWidget {
  const FourthLevelPage({super.key});

  @override
  State<FourthLevelPage> createState() => _FourthLevelPageState();
}

class _FourthLevelPageState extends State<FourthLevelPage> {
  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      levelNumber: 4,
      ghostsCount: 1,
      ghostsSpeed: 450,
      barriers: fourthLevelBarriers,
    );
  }
}
