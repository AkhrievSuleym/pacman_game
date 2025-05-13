import 'package:flutter/material.dart';
import 'package:pacman_game/barriers/levels_barriers.dart';
import 'package:pacman_game/presentation/widgets/level_widget.dart';

class SixthLevelPage extends StatefulWidget {
  const SixthLevelPage({super.key});

  @override
  State<SixthLevelPage> createState() => _SixthLevelPageState();
}

class _SixthLevelPageState extends State<SixthLevelPage> {
  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      levelNumber: 6,
      ghostsCount: 1,
      ghostsSpeed: 550,
      barriers: fourthLevelBarriers,
    );
  }
}
