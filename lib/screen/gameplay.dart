import 'package:flutter/material.dart';
import 'package:flutter_snake_game/model/head.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  //
  late double boardSize;
  late GyroscopeEvent _gyroscopeEvent;

  void getBoardSize() {
    var gameController = Provider.of<GameController>(context, listen: false);
    boardSize = gameController.boardSize;
    print(gameController.boardSize.toStringAsFixed(2));
  }

  void playGame() {
    var gameController = Provider.of<GameController>(context, listen: false);
    gameController.playGame();
  }

  setGyroscope() {
    gyroscopeEvents.listen((event) {
      var gameController = Provider.of<GameController>(context, listen: false);
      gameController.updateGyro(event.x, event.y, event.z);
    });
  }

  @override
  void initState() {
    getBoardSize();
    playGame();
    setGyroscope();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SNAKE GAME"),
                  Text("POIN : 123"),
                ],
              ),
            ),
            Consumer<GameController>(
              builder: (context, game, child) {
                return GestureDetector(
                  onVerticalDragStart: (details) {
                    game.dragStart = details.localPosition;
                  },
                  onVerticalDragUpdate: (details) {
                    game.dragEnd = details.localPosition;
                  },
                  child: Container(
                    width: boardSize,
                    height: boardSize,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Stack(
                      children: [
                        SnakeHead(),
                      ],
                    ),
                  ),
                );
              },
            ),
            Consumer<GameController>(
              builder: (context, game, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("X : " + game.gyroscopeValue[0].toStringAsFixed(2)),
                        Text("Y : " + game.gyroscopeValue[1].toStringAsFixed(2)),
                        Text("Z : " + game.gyroscopeValue[2].toStringAsFixed(2)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Axis Rotation : " +
                          (game.isNegative ? "-" : "") +
                          (game.axisIndex == 0
                              ? "X"
                              : game.axisIndex == 1
                                  ? "Y"
                                  : "Z"),
                    ),
                    const SizedBox(height: 20),
                    Text("DIRECTION : " + (game.direction.name)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
