import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/pages/first_level_page.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/ghost.png',
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
      body: Container(
        child: Column(
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
                    number: '1', nextPage: FirstLevelPage(), open_check: true),
                SquareButton(number: '2', nextPage: Center(), open_check: true),
                SquareButton(number: '3', nextPage: Center(), open_check: false)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String number;
  final Widget nextPage;
  final bool open_check;

  const SquareButton(
      {required this.number, required this.nextPage, required this.open_check});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (open_check) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => nextPage));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Этот уровень заблокирован')),
          );
        }
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
          child: open_check
              ? Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                )
              : const Text(
                  '🔒',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
        ),
      ),
    );
  }
}
