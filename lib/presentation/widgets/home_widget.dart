import 'package:flutter/material.dart';
import 'package:pacman_game/presentation/pages/levels_page.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/image/pacman.png',
            width: 200,
            height: 200,
          ),
          const Text(
            "Pacman",
            style: AppTextStyles.heading,
          ),
          const SizedBox(
            height: 10.0,
          ),
          OutlinedButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LevelsPage())),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 65, 64, 64),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              side: BorderSide(
                  width: 2, color: const Color.fromARGB(255, 151, 147, 147)),
            ),
            child: const Text(
              "Start Game",
              style: AppTextStyles.subheading,
            ),
          ),
        ],
      )),
    );
  }
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontFamily: "Phudu",
    color: Color.fromARGB(255, 255, 215, 0),
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontFamily: 'Phudu',
    color: Color.fromARGB(255, 255, 215, 0),
  );
}
