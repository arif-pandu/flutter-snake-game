import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';

class GameController with ChangeNotifier {
  /// Variable

  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _boardSize = 0;
  double _snakePartSize = 0.0;
  int snakeLength = 0;

  List<double> _food = [-15, -15];

  List<double> gyroscopeValue = [0, 0, 0];
  List<double> _snakeHead = [0, 0];
  List<double> _snakeNeck = [0, 0];
  List<List<double>> _snakeBody = [];

  int axisIndex = 0;
  bool isNegative = false;
  Direction direction = Direction.idle;
  Direction lastDirection = Direction.idle;
  Alignment _headAlign = Alignment.center;
  Axis _headAxisAlign = Axis.horizontal;

  /// Getter
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get boardSize => _boardSize;
  double get snakePartSize => _snakePartSize;
  List<double> get food => _food;
  List<double> get snakeHead => _snakeHead;
  List<double> get snakeNeck => _snakeNeck;
  List<List<double>> get snakeBody => _snakeBody;

  Alignment get headAlign => _headAlign;
  Axis get headAxisAlign => _headAxisAlign;

  /// Setter

  set boardSize(double value) {
    _boardSize = value;
    notifyListeners();
  }

  set snakePartSize(double value) {
    _snakePartSize = value;
    notifyListeners();
  }

  set food(List<double> value) {
    _food = value;
    notifyListeners();
  }

  set snakeHead(List<double> value) {
    _snakeHead = value;
    notifyListeners();
  }

  set snakeNeck(List<double> value) {
    _snakeNeck = value;
    notifyListeners();
  }

  set snakeBody(List<List<double>> value) {
    _snakeBody = value;
    notifyListeners();
  }

  set headAlign(Alignment value) {
    _headAlign = value;
    notifyListeners();
  }

  set headAxisAlign(Axis value) {
    _headAxisAlign = value;
    notifyListeners();
  }

  /// Void
  ///

  void setDevSize(double height, double width) {
    _screenHeight = height;
    _screenWidth = width;

    _boardSize = (width - 10) - (_screenWidth % 20);
    _snakePartSize = boardSize / 20;
    _snakeHead = [(_boardSize / 2), (_boardSize / 2) - _snakePartSize];
    notifyListeners();
    print("Screen Size Saved!");
    print("Board : " + _boardSize.toStringAsFixed(2));
    print("Part : " + _snakePartSize.toStringAsFixed(2));
    print("Offset : ${_boardSize / 2}, ${(_boardSize / 2) - _snakePartSize}");
  }

  void updateGyro(double x, double y, double z) {
    gyroscopeValue = [x, y, z];
    updateData();
    notifyListeners();
  }

  void updateData() {
    List<double> tempList = [];

    var indexLarge = () {
      for (var i = 0; i < gyroscopeValue.length; i++) {
        tempList.add(gyroscopeValue[i].abs());
      }
      double largest = tempList.reduce(max);

      if (largest >= 1.5) {
        return tempList.indexWhere((element) => element == largest);
      } else {
        return axisIndex;
      }
    }();

    axisIndex = indexLarge;
    checkNegative();
  }

  void checkNegative() {
    if (gyroscopeValue[axisIndex] <= 1.0) {
      isNegative = true;
    } else if (gyroscopeValue[axisIndex] >= 1.0) {
      isNegative = false;
    }
    checkDirection();
  }

  void checkDirection() {
    if (axisIndex == 0) {
      if (gyroscopeValue[0] <= -1.0) {
        if (lastDirection != Direction.down) {
          direction = Direction.up;
        }
      } else if (gyroscopeValue[0] >= 1.0) {
        if (lastDirection != Direction.up) {
          direction = Direction.down;
        }
      }
    } else if (axisIndex == 1) {
      if (gyroscopeValue[1] <= -1.5) {
        if (lastDirection != Direction.right) {
          direction = Direction.left;
        }
      } else if (gyroscopeValue[1] >= 1.5) {
        if (lastDirection != Direction.left) {
          direction = Direction.right;
        }
      }
    } else {
      print("Ngapain muter muter oi");
    }
    notifyListeners();

    print("Last Direction " + lastDirection.name.toString());
  }

  void straightAhead() {
    if (direction == Direction.right) {
      snakeHead[0] = snakeHead[0] += snakePartSize;
      headAlign = Alignment.centerLeft;
      headAxisAlign = Axis.horizontal;
      lastDirection = Direction.right;
    } else if (direction == Direction.left) {
      snakeHead[0] = snakeHead[0] -= snakePartSize;
      headAlign = Alignment.centerRight;
      headAxisAlign = Axis.horizontal;
      lastDirection = Direction.left;
    } else if (direction == Direction.down) {
      snakeHead[1] = snakeHead[1] += snakePartSize;
      headAlign = Alignment.topCenter;
      headAxisAlign = Axis.vertical;
      lastDirection = Direction.down;
    } else if (direction == Direction.up) {
      snakeHead[1] = snakeHead[1] -= snakePartSize;
      headAlign = Alignment.bottomCenter;
      headAxisAlign = Axis.vertical;
      lastDirection = Direction.up;
    }
  }

  void spreadFood() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        int random1 = Random().nextInt(20);
        int random2 = Random().nextInt(20);

        double tempFood1 = random1 * snakePartSize;
        double tempFood2 = random2 * snakePartSize;

        food = [tempFood1, tempFood2];
      },
    );
  }

  void turnRight() {}

  void turnLeft() {}

  void turnUp() {}

  void turnDown() {}
}
