import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/model/body.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class SnakeProvider with ChangeNotifier {
  SnakeProvider(this.gameProvider);
  final GameProvider gameProvider;

  List<int> barrierRight = [19, 39, 59, 79, 99, 119, 139, 159, 179, 199, 219, 239, 259, 279, 299, 319, 339, 359, 379, 399];
  List<int> barrierLeft = [0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380];
  List<int> barrierUp = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
  List<int> barrierDown = [380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399];

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
    print(gameProvider.snakeHead.toString());

    if (gameProvider.direction == Direction.right) {
      checkBarrierHead(
        Direction.right,
      );
      gameProvider.headAlign = Alignment.centerLeft;
      gameProvider.headAxisAlign = Axis.horizontal;
      gameProvider.lastDirection = Direction.right;
    } else if (gameProvider.direction == Direction.left) {
      checkBarrierHead(
        Direction.left,
      );
      gameProvider.headAlign = Alignment.centerRight;
      gameProvider.headAxisAlign = Axis.horizontal;
      gameProvider.lastDirection = Direction.left;
    } else if (gameProvider.direction == Direction.down) {
      checkBarrierHead(
        Direction.down,
      );
      gameProvider.headAlign = Alignment.topCenter;
      gameProvider.headAxisAlign = Axis.vertical;
      gameProvider.lastDirection = Direction.down;
    } else if (gameProvider.direction == Direction.up) {
      checkBarrierHead(
        Direction.up,
      );
      gameProvider.headAlign = Alignment.bottomCenter;
      gameProvider.headAxisAlign = Axis.vertical;
      gameProvider.lastDirection = Direction.up;
    }

    neckFollowHead();
    notifyListeners();
  }

  checkBarrierHead(Direction direction) {
    /// If Snake Head Walking Across the Edge of the Board
    if (direction == Direction.right) {
      if (barrierRight.contains(gameProvider.snakeHead)) {
        gameProvider.snakeHead = gameProvider.snakeHead - 19;
      } else {
        gameProvider.snakeHead++;
      }
    } else if (direction == Direction.left) {
      if (barrierLeft.contains(gameProvider.snakeHead)) {
        gameProvider.snakeHead = gameProvider.snakeHead + 19;
      } else {
        gameProvider.snakeHead--;
      }
    } else if (direction == Direction.up) {
      if (barrierUp.contains(gameProvider.snakeHead)) {
        gameProvider.snakeHead = gameProvider.snakeHead + 380;
      } else {
        gameProvider.snakeHead -= 20;
      }
    } else if (direction == Direction.down) {
      if (barrierDown.contains(gameProvider.snakeHead)) {
        gameProvider.snakeHead = gameProvider.snakeHead - 380;
      } else {
        gameProvider.snakeHead += 20;
      }
    }
    notifyListeners();
  }

  void neckFollowHead() {
    if (gameProvider.direction == Direction.right) {
      if (barrierLeft.contains(gameProvider.snakeHead)) {
        gameProvider.snakeNeck = gameProvider.snakeHead + 19;
      } else {
        gameProvider.snakeNeck = gameProvider.snakeHead - 1;
      }
    } else if (gameProvider.direction == Direction.left) {
      if (barrierRight.contains(gameProvider.snakeHead)) {
        gameProvider.snakeNeck = gameProvider.snakeHead - 19;
      } else {
        gameProvider.snakeNeck = gameProvider.snakeHead + 1;
      }
    } else if (gameProvider.direction == Direction.down) {
      if (barrierUp.contains(gameProvider.snakeHead)) {
        gameProvider.snakeNeck = gameProvider.snakeHead + 380;
      } else {
        gameProvider.snakeNeck = gameProvider.snakeHead - 20;
      }
    } else if (gameProvider.direction == Direction.up) {
      if (barrierDown.contains(gameProvider.snakeHead)) {
        gameProvider.snakeNeck = gameProvider.snakeHead - 380;
      } else {
        gameProvider.snakeNeck = gameProvider.snakeHead + 20;
      }
    }

    bodyFollowNeck();
  }

  // void checkBarrierNeck(Direction direction) {
  //   if (direction == Direction.up) {
  //     if (barrierDown.contains(gameProvider.snakeHead)) {
  //       gameProvider.snakeNeck = gameProvider.snakeHead - 380;
  //     } else {
  //       gameProvider.snakeNeck = gameProvider.snakeHead + 20;
  //     }
  //   }
  // }

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
