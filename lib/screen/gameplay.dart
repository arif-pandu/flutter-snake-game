import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/model/food.dart';
import 'package:flutter_snake_game/model/head.dart';
import 'package:flutter_snake_game/model/neck.dart';
import 'package:flutter_snake_game/model/tail.dart';
import 'package:flutter_snake_game/provider/food_provider.dart';
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

  void getBoardSize() {
    var gameProvider = Provider.of<GameProvider>(context, listen: false);
    boardSize = gameProvider.boardSize;
    // print("Board Size : " + gameProvider.boardSize.toStringAsFixed(2));
  }

  void setGyroscope() {
    gyroscopeEvents.listen((event) {
      var gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.updateGyro(event.x, event.y, event.z);
    });
  }

  void setFood() {
    var foodProvider = Provider.of<FoodProvider>(context, listen: false);
    foodProvider.spreadFood();
  }

  @override
  void initState() {
    getBoardSize();
    setGyroscope();
    setFood();
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
            Consumer<GameProvider>(
              builder: (context, game, child) {
                return Container(
                  width: boardSize,
                  height: boardSize,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Stack(
                    children: [
                      const Food(),
                      const SnakeTail(),
                      ...game.bodyMember,
                      const SnakeNeck(),
                      const SnakeHead(),
                    ],
                  ),
                );
              },
            ),
            Consumer<GameProvider>(
              builder: (context, game, _) {
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            game.direction = Direction.up;
                          },
                          child: Text("Up"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            game.direction = Direction.down;
                          },
                          child: Text("Down"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            game.direction = Direction.right;
                          },
                          child: Text("Right"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            game.direction = Direction.left;
                          },
                          child: Text("Left"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            game.testConnect();
                          },
                          child: Text("TEST"),
                        ),
                        // Consumer<CoordinateProvider>(
                        //   builder: (context, areaCoor, _) {
                        //     return ElevatedButton(
                        //       onPressed: () {
                        //         print(areaCoor.listCoordinates);
                        //       },
                        //       child: Text("test"),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
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
