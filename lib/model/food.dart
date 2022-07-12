import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Food extends StatelessWidget {
  const Food({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, game, _) {
        return Positioned(
          left: game.food[0],
          top: game.food[1],
          // left: 0,
          // right: 0,
          child: Container(
            height: game.snakePartSize * 0.8,
            width: game.snakePartSize * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.red[700],
            ),
          ),
        );
      },
    );
  }
}
