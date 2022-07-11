import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';

class GameController with ChangeNotifier {
  /// Constant Var
  // final Direction _direction = Direction.values[Random().nextInt(Direction.values.length)];
  // final Direction _direction = Direction.right;

  /// Variable
  late Timer _timer;
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _boardSize = 0;
  double _snakePartSize = 0.0;
  int _snakeLength = 0;
  List<double> _snakeHead = [0, 0];
  List<double> _snakeNeck = [0, 0];
  List<double> _snakeBody = [];
  late Offset _dragStart;
  late Offset _dragEnd;
  List<double> gyroscopeValue = [0, 0, 0];
  int axisIndex = 0;
  bool isNegative = false;
  Direction direction = Direction.idle;

  /// Getter
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get boardSize => _boardSize;
  double get snakePartSize => _snakePartSize;
  int get snakeLength => _snakeLength;
  List<double> get snakeHead => _snakeHead;
  List<double> get snakeNeck => _snakeNeck;
  List<double> get snakeBody => _snakeBody;
  Offset get dragStart => _dragStart;
  Offset get dragEnd => _dragEnd;

  /// Setter

  set boardSize(double value) {
    _boardSize = value;
    notifyListeners();
  }

  set snakePartSize(double value) {
    _snakePartSize = value;
    notifyListeners();
  }

  set snakeLength(int value) {
    _snakeLength = value;
  }

  set snakeHead(List<double> value) {
    _snakeHead = value;
    notifyListeners();
  }

  set snakeNeck(List<double> value) {
    _snakeNeck = value;
    notifyListeners();
  }

  set snakeBody(List<double> value) {
    _snakeBody = value;
    notifyListeners();
  }

  set dragStart(Offset value) {
    _dragStart = value;
    notifyListeners();
  }

  set dragEnd(Offset value) {
    _dragEnd = value;
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

  void playGame() {
    print('====== GOTO $direction ===========');
    Future.delayed(
      Duration(seconds: 2),
      () {
        _timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (timer) {
            updateMove();
          },
        );
      },
    );
  }

  void updateGyro(double x, double y, double z) {
    gyroscopeValue = [x, y, z];

    updateData();
    print(gyroscopeValue.toString());

    notifyListeners();
  }

  void updateData() {
    List<double> tempList = [];

    var indexLarge = () {
      for (var i = 0; i < gyroscopeValue.length; i++) {
        tempList.add(gyroscopeValue[i].abs());
      }
      double largest = tempList.reduce(max);
      return tempList.indexWhere((element) => element == largest);
    }();

    axisIndex = indexLarge;
    checkNegative();

    print("Axis Index : " + indexLarge.toString());
    print(gyroscopeValue.toString());
  }

  void checkNegative() {
    if (gyroscopeValue[axisIndex] < 0) {
      isNegative = true;
    } else {
      isNegative = false;
    }
    checkDirection();
  }

  void checkDirection() {
    if (axisIndex == 0) {
      if (isNegative) {
        direction = Direction.up;
      } else {
        direction = Direction.down;
      }
    } else if (axisIndex == 1) {
      if (isNegative) {
        direction = Direction.left;
      } else {
        direction = Direction.right;
      }
    } else {
      print("Ngapain muter muter oi");
    }
  }

  void updateMove() {
    /// [0] = Horizontal
    /// [1] = Vertical

    if (direction == Direction.right) {
      turnRight();
    } else if (direction == Direction.left) {
      turnLeft();
    } else if (direction == Direction.up) {
      turnUp();
    } else if (direction == Direction.down) {
      turnDown();
    }

    notifyListeners();
  }

  void addLength() {
    _snakeLength++;
  }

  void straightAhead() {
    if (direction == Direction.right) {
      snakeHead[0] = snakeHead[0] += snakePartSize;
    } else if (direction == Direction.left) {
      snakeHead[0] = snakeHead[0] -= snakePartSize;
    } else if (direction == Direction.down) {
      snakeHead[1] = snakeHead[1] += snakePartSize;
    } else if (direction == Direction.up) {
      snakeHead[1] = snakeHead[1] -= snakePartSize;
    }

    // if(){

    // }
  }

  void turnRight() {}

  void turnLeft() {}

  void turnUp() {}

  void turnDown() {}
}
