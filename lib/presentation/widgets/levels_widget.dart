import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/widgets/home_widget.dart';

class LevelsWidget extends StatefulWidget {
  const LevelsWidget({super.key});

  @override
  State<LevelsWidget> createState() => _LevelsWidgetState();
}

class _LevelsWidgetState extends State<LevelsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/ghost.png',
              width: 100,
              height: 100,
            ),
            Text("Pacman", style: AppTextStyles.heading),
            Image.asset(
              'assets/image/pacman.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
