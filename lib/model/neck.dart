import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class SnakeNeck extends StatelessWidget {
  const SnakeNeck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Positioned(
          // left: game.snakeNeck[0],
          // top: game.snakeNeck[1],
          left: -40,
          top: -40,
          child: Container(
            height: game.snakePartSize,
            width: game.snakePartSize,
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
