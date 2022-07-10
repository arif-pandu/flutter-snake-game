import 'package:flutter/material.dart';
import 'package:flutter_snake_game/model/snake.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  //
  late double boardSize;

  void getBoardSize() {
    var gameController = Provider.of<GameController>(context, listen: false);
    boardSize = gameController.boardSize;
    print(gameController.boardSize.toStringAsFixed(2));
  }

  void playGame() {
    var gameController = Provider.of<GameController>(context, listen: false);
    gameController.playGame();
  }

  @override
  void initState() {
    getBoardSize();
    playGame();
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
                        Snake(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
