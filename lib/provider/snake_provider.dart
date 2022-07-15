import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/model/body.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class SnakeProvider with ChangeNotifier {
  SnakeProvider(this.gameProvider);
  final GameProvider gameProvider;

  createHistory(List<int> value) {
    gameProvider.snakeHistory = value;
    notifyListeners();
  }

  void straightAhead() {
    createHistory(
      [
        gameProvider.snakeHead,
        gameProvider.snakeNeck,
      ],
    );
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
      // First Body Member
      // if (item.number == 0) {
      //   if (gameProvider.direction == Direction.right) {
      //     switch (gameProvider.lastDirection) {
      //       case Direction.up:
      //         break;
      //       case Direction.down:
      //         // TODO: Handle this case.
      //         break;
      //       case Direction.right:
      //         // TODO: Handle this case.
      //         break;
      //       case Direction.left:
      //         // TODO: Handle this case.
      //         break;
      //       case Direction.idle:
      //         // TODO: Handle this case.
      //         break;
      //     }
      //   }
      if (gameProvider.direction == Direction.right) {
        gameProvider.snakeBody[0] = gameProvider.snakeHistory[1];
      } else if (gameProvider.direction == Direction.left) {
        gameProvider.snakeBody[0] = gameProvider.snakeHistory[1];
      } else if (gameProvider.direction == Direction.down) {
        gameProvider.snakeBody[0] = gameProvider.snakeHistory[1];
      } else if (gameProvider.direction == Direction.up) {
        gameProvider.snakeBody[0] = gameProvider.snakeHistory[1];
        // }
        notifyListeners();
      }
      // Second and so on body members
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
    }
  }
}
