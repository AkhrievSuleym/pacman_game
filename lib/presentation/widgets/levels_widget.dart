import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/pages/first_level_page.dart';
import 'package:pacman_game/presentation/pages/second_level_page.dart';
import 'package:pacman_game/presentation/widgets/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelsWidget extends StatefulWidget {
  const LevelsWidget({super.key});

  @override
  State<LevelsWidget> createState() => _LevelsWidgetState();
}

class _LevelsWidgetState extends State<LevelsWidget> {
  int lastCompletedLevel = 0;

  @override
  void initState() {
    super.initState();
    _loadLastCompletedLevel();
  }

  Future<void> _loadLastCompletedLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lastCompletedLevel = prefs.getInt('last_completed_level') ?? 0;
      print("Last completed level: $lastCompletedLevel");
    });
  }

  Future<void> _updateLastCompletedLevel(int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_completed_level', level);
    setState(() {
      lastCompletedLevel = level; // Обновляем состояние
    });
    print("Updated last completed level to: $level");
  }

  Future<void> _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Удаляет все данные
    setState(() {
      lastCompletedLevel = 0; // Обновляем состояние, если нужно
    });
    print("SharedPreferences cleared");
  }

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
      body: Column(
        children: [
          const Center(
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
                nextPage: const FirstLevelPage(),
                open_check: true,
                onLevelCompleted: () => _updateLastCompletedLevel(1),
              ),
              SquareButton(
                number: '2',
                nextPage: const SecondLevelPage(),
                open_check: lastCompletedLevel >= 1,
                onLevelCompleted: () => _updateLastCompletedLevel(2),
              ),
              SquareButton(
                number: '3',
                nextPage: const Center(),
                open_check: lastCompletedLevel >= 2,
                onLevelCompleted: () => _updateLastCompletedLevel(3),
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
  final bool open_check;
  final VoidCallback onLevelCompleted;

  const SquareButton(
      {required this.number,
      required this.nextPage,
      required this.open_check,
      required this.onLevelCompleted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (open_check) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => nextPage))
              .then((_) => onLevelCompleted());
          ;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This block is blocked')),
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
