import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Snake Game",
              style: TextStyle(
                fontSize: 40,
                color: AppColor.accentColor,
              ),
            ),
            InkWell(
              onTap: () {
                context.read<GameProvider>().setDevSize(height, width);
                Navigator.of(context).pushReplacementNamed("/play");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColor.accentColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                child: const Text(
                  "PLAY",
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
