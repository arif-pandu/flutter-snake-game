import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class SnakeBody extends StatelessWidget {
  const SnakeBody({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  int get number => this.index;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Positioned(
          left: game.listCoordinate[game.snakeBody[index]].x.toDouble(),
          top: game.listCoordinate[game.snakeBody[index]].y.toDouble(),
          // left: -40,
          // top: -40,
          child: Container(
            height: game.snakePartSize,
            width: game.snakePartSize,
            color: AppColor.snakeColor,
          ),
        );
      },
    );
  }
}
