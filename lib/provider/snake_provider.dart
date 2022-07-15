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
    neckFollowHead();
    notifyListeners();
  }

  void neckFollowHead() {
    var _temp = 0;
    _temp = gameProvider.snakeHead;

    if (gameProvider.direction == Direction.right) {
      gameProvider.snakeNeck = _temp - 1;
    } else if (gameProvider.direction == Direction.left) {
      gameProvider.snakeNeck = _temp + 1;
    } else if (gameProvider.direction == Direction.down) {
      gameProvider.snakeNeck = _temp - 20;
    } else if (gameProvider.direction == Direction.up) {
      gameProvider.snakeNeck = _temp + 20;
    }
  }
}
