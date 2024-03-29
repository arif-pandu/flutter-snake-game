// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/model/food.dart';
import 'package:flutter_snake_game/model/head.dart';
import 'package:flutter_snake_game/model/neck.dart';
import 'package:flutter_snake_game/model/popup_menu.dart';
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
  final _streamSubscriptions = <StreamSubscription<GyroscopeEvent>>[];

  void getBoardSize() {
    var gameProvider = Provider.of<GameProvider>(context, listen: false);
    boardSize = gameProvider.boardSize;
    // print("Board Size : " + gameProvider.boardSize.toStringAsFixed(2));
  }

  void setGyroscope() {
    _streamSubscriptions.add(gyroscopeEvents.listen((event) {
      var gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.updateGyro(event.x, event.y, event.z);
    }));
  }

  void setFood() {
    var foodProvider = Provider.of<FoodProvider>(context, listen: false);
    foodProvider.spreadFood();
    print("Food Spreaded");
  }

  @override
  void initState() {
    getBoardSize();
    setGyroscope();
    setFood();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    for (var item in _streamSubscriptions) {
      item.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return popUpMenu(context);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "SCORE :",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Consumer<GameProvider>(
                      builder: (context, game, child) {
                        return Text(
                          game.snakeLength.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Consumer<GameProvider>(
                builder: (context, game, child) {
                  return Container(
                    width: boardSize,
                    height: boardSize,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.accentColor),
                    ),
                    child: Stack(
                      children: [
                        const Food(),
                        ...game.bodyMember,
                        const SnakeNeck(),
                        const SnakeHead(),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "source : github.com/arif-pandu",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColor.accentColor.withOpacity(0.2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              // Consumer<GameProvider>(
              //   builder: (context, game, _) {
              //     return Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         const SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             ElevatedButton(
              //               onPressed: () {
              //                 game.direction = Direction.up;
              //               },
              //               child: Text("Up"),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 game.direction = Direction.down;
              //               },
              //               child: Text("Down"),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 game.direction = Direction.right;
              //               },
              //               child: Text("Right"),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 game.direction = Direction.left;
              //               },
              //               child: Text("Left"),
              //             ),
              //           ],
              //         ),
              //       ],
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
