import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/pages/fifth_level_page.dart';
import 'package:pacman_game/presentation/pages/first_level_page.dart';
import 'package:pacman_game/presentation/pages/fourth_level_page.dart';
import 'package:pacman_game/presentation/pages/second_level_page.dart';
import 'package:pacman_game/presentation/pages/third_level_page.dart';
import 'package:pacman_game/presentation/widgets/home_widget.dart';

class LevelsWidget extends StatefulWidget {
  const LevelsWidget({super.key});

  @override
  State<LevelsWidget> createState() => _LevelsWidgetState();
}

class _LevelsWidgetState extends State<LevelsWidget> {
  int lastCompletedLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/ghost1.png',
              width: 42,
              height: 42,
            ),
            const SizedBox(
              width: 10,
            ),
            Text("Pacman", style: AppTextStyles.heading),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/image/pacman.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          Center(
            child: Text(
              "Levels",
              style: AppTextStyles.heading,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquareButton(
                number: '1',
                nextPage: FirstLevelPage(),
              ),
              SquareButton(
                number: '2',
                nextPage: SecondLevelPage(),
              ),
              SquareButton(
                number: '3',
                nextPage: ThirdLevelPage(),
              ),
              SquareButton(
                number: '4',
                nextPage: FourthLevelPage(),
              ),
              SquareButton(
                number: '5',
                nextPage: FifthLevelPage(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String number;
  final Widget nextPage;

  const SquareButton({
    required this.number,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => nextPage));
      },
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 117, 118, 119),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
