import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class SnakeProvider with ChangeNotifier {
  SnakeProvider(this.gameProvider);
  final GameProvider gameProvider;

  void straightAhead() {
    if (gameProvider.direction == Direction.right) {
      gameProvider.snakeHead[0];
      //
    } else if (gameProvider.direction == Direction.left) {
    } else if (gameProvider.direction == Direction.down) {
    } else if (gameProvider.direction == Direction.up) {}
  }
}
