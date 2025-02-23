import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/widgets/levels_widget.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({super.key});

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  Widget build(BuildContext context) {
    return LevelsWidget();
  }
}
