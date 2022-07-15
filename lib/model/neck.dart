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
          left: game.listCoordinate[game.snakeNeck].x.toDouble(),
          top: game.listCoordinate[game.snakeNeck].y.toDouble(),
          child: Container(
            height: game.snakePartSize,
            width: game.snakePartSize,
            color: Colors.green,
            // decoration: BoxDecoration(
            //   color: (game.listCoordinate[game.snakeNeck]) == (game.listCoordinate[game.snakeHead]) //
            //       ? Colors.transparent
            //       : Colors.green,
            //   border: Border.symmetric(
            //     vertical: !((game.listCoordinate[game.snakeNeck]) == (game.listCoordinate[game.snakeHead])) && (game.headAxisAlign == Axis.vertical)
            //         ? BorderSide(width: 1, color: Colors.black)
            //         : BorderSide.none,
            //     horizontal: !((game.listCoordinate[game.snakeNeck]) == (game.listCoordinate[game.snakeHead])) && (game.headAxisAlign == Axis.horizontal)
            //         ? BorderSide(width: 1, color: Colors.black)
            //         : BorderSide.none,
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
