import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class SnakeProvider with ChangeNotifier {
  SnakeProvider(this.gameProvider);
  final GameProvider gameProvider;

  void straightAhead() {
    if (gameProvider.direction == Direction.right) {
      gameProvider.snakeHead++;
      gameProvider.headAlign = Alignment.centerLeft;
      gameProvider.headAxisAlign = Axis.horizontal;
      gameProvider.lastDirection = Direction.right;
    } else if (gameProvider.direction == Direction.left) {
      gameProvider.snakeHead--;
      gameProvider.headAlign = Alignment.centerRight;
      gameProvider.headAxisAlign = Axis.horizontal;
      gameProvider.lastDirection = Direction.left;
    } else if (gameProvider.direction == Direction.down) {
      gameProvider.snakeHead += 20;
      gameProvider.headAlign = Alignment.topCenter;
      gameProvider.headAxisAlign = Axis.vertical;
      gameProvider.lastDirection = Direction.down;
    } else if (gameProvider.direction == Direction.up) {
      gameProvider.snakeHead -= 20;
      gameProvider.headAlign = Alignment.bottomCenter;
      gameProvider.headAxisAlign = Axis.vertical;
      gameProvider.lastDirection = Direction.up;
    }

    print("Maju Lurus");
    print(gameProvider.snakeHead);

    notifyListeners();
  }

  //  void straightAhead() {
  //   if (direction == Direction.right) {
  //     snakeHead[0] = snakeHead[0] += snakePartSize;
  //     neckFollowHead(0, false, 1);
  //     headAlign = Alignment.centerLeft;
  //     headAxisAlign = Axis.horizontal;
  //     lastDirection = Direction.right;
  //   } else if (direction == Direction.left) {
  //     snakeHead[0] = snakeHead[0] -= snakePartSize;
  //     neckFollowHead(0, true, 1);
  //     headAlign = Alignment.centerRight;
  //     headAxisAlign = Axis.horizontal;
  //     lastDirection = Direction.left;
  //   } else if (direction == Direction.down) {
  //     snakeHead[1] = snakeHead[1] += snakePartSize;
  //     neckFollowHead(1, false, 0);
  //     headAlign = Alignment.topCenter;
  //     headAxisAlign = Axis.vertical;
  //     lastDirection = Direction.down;
  //   } else if (direction == Direction.up) {
  //     snakeHead[1] = snakeHead[1] -= snakePartSize;
  //     neckFollowHead(1, true, 0);
  //     headAlign = Alignment.bottomCenter;
  //     headAxisAlign = Axis.vertical;
  //     lastDirection = Direction.up;
  //   }
  // }
}
