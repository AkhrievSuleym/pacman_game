import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/widgets/first_level_widget.dart';

class FirstLevelPage extends StatefulWidget {
  const FirstLevelPage({super.key});

  @override
  State<FirstLevelPage> createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  @override
  Widget build(BuildContext context) {
    return FirstLevelWidget();
  }
}
