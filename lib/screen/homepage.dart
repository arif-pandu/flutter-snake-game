import 'package:flutter/material.dart';
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
            const Text("Snake Game"),
            ElevatedButton(
              onPressed: () {
                context.read<GameProvider>().setDevSize(height, width);
                Navigator.of(context).pushReplacementNamed("/play");
              },
              child: Text("Play"),
            ),
          ],
        ),
      ),
    );
  }
}
