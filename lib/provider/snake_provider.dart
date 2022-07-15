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

    // gameProvider.snakeHistory.add(gameProvider.snakeHead);
    // gameProvider.snakeHistory.add(gameProvider.snakeNeck);
    // if (gameProvider.snakeBody.isNotEmpty) {
    //   for (var item in gameProvider.snakeBody) {
    //     gameProvider.snakeHistory.add(item);
    //   }
    // }

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
  }

  void setBodyPosition() {
    // if snake.length == 0 => follow neck
    // if snake.length > 0  => follow index before
    if (gameProvider.snakeLength == 0) {
      if (gameProvider.direction == Direction.right) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[1] - 1);
      } else if (gameProvider.direction == Direction.left) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[1] + 1);
      } else if (gameProvider.direction == Direction.down) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[1] - 20);
      } else if (gameProvider.direction == Direction.up) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[1] + 20);
      }
      gameProvider.bodyMember.add(SnakeBody(index: 0));
      gameProvider.snakeLength++;
      //
    } else if (gameProvider.snakeLength > 0) {
      //
      if (gameProvider.direction == Direction.right) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[gameProvider.snakeLength] - 1);
      } else if (gameProvider.direction == Direction.left) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[gameProvider.snakeLength] + 1);
      } else if (gameProvider.direction == Direction.down) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[gameProvider.snakeLength] - 20);
      } else if (gameProvider.direction == Direction.up) {
        gameProvider.snakeBody.add(gameProvider.snakeHistory[gameProvider.snakeLength] + 20);
      }

      gameProvider.bodyMember.add(SnakeBody(index: gameProvider.snakeLength));
      gameProvider.snakeLength++;
    }
    notifyListeners();
  }
}
