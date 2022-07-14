import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class SnakeBody extends StatelessWidget {
  const SnakeBody({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, game, child) {
        return Positioned(
          left: game.snakeBody[index][0],
          top: game.snakeBody[index][1],
          // left: 0,
          // top: 0,
          child: Container(
            height: game.snakePartSize,
            width: game.snakePartSize,
            color: Colors.black54,
          ),
        );
      },
    );
  }
}
