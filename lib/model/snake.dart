import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Snake extends StatefulWidget {
  const Snake({
    Key? key,
  }) : super(key: key);

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, game, child) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 100),
          left: game.snakeHead[0],
          top: game.snakeHead[1],
          child: Container(
            height: game.snakePartSize,
            width: game.snakePartSize,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
