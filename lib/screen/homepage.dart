import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    void setDeviceSize(double width, double height) {
      var gameController = Provider.of<GameController>(context, listen: false);
      gameController.setDevSize(height, width);
      Navigator.of(context).pushReplacementNamed("/play");
    }

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
                setDeviceSize(width, height);
              },
              child: Text("Play"),
            ),
          ],
        ),
      ),
    );
  }
}
