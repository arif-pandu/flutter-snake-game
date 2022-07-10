import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  void setDeviceSize(double width, double height) {
    var gameController = Provider.of<GameController>(context, listen: false);
    gameController.setDevSize(height, width);

    Navigator.of(context).pushReplacementNamed("/play");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Snake Game"),
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
