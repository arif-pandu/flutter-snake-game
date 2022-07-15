import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/model/body.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class SnakeProvider with ChangeNotifier {
  SnakeProvider(this.gameProvider);
  final GameProvider gameProvider;

  createHistory() {
    // Create History By Last Move Point
    List<int> tempList = [];

    tempList.add(gameProvider.snakeHead);
    tempList.add(gameProvider.snakeNeck);
    if (gameProvider.snakeBody.isNotEmpty) {
      for (var item in gameProvider.snakeBody) {
        tempList.add(item);
      }
    }

    gameProvider.snakeHistory = tempList;
    notifyListeners();
  }

  void straightAhead() {
    createHistory();

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

    bodyFollowNeck();
  }

  void bodyFollowNeck() {
    for (var item in gameProvider.bodyMember) {
      gameProvider.snakeBody[item.number] = gameProvider.snakeHistory[item.number + 1];
      notifyListeners();
    }
  }

  void addBody() {
    setBodyPosition();
    gameProvider.bodyMember.add(SnakeBody(index: gameProvider.snakeLength));
    gameProvider.snakeLength++;
    notifyListeners();
  }

  void setBodyPosition() {
    gameProvider.snakeBody.add(gameProvider.snakeHistory[gameProvider.snakeLength + 1]);
  }
}
