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
  int _boxHorizCount = 20;
  int _boxVertCount = 20;
  int _snakeLength = 0;
  List _snakeHead = [0, 0];
  List _snakeNeck = [0, 0];
  List _snakeBody = [];
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
  int get boxHorizCount => _boxHorizCount;
  int get boxVertCount => _boxVertCount;
  int get snakeLength => _snakeLength;
  List get snakeHead => _snakeHead;
  List get snakeNeck => _snakeNeck;
  List get snakeBody => _snakeBody;
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

  set boxHorizCount(int value) {
    _boxHorizCount = value;
    notifyListeners();
  }

  set boxVertCount(int value) {
    _boxVertCount = value;
    notifyListeners();
  }

  set snakeLength(int value) {
    _snakeLength = value;
  }

  set snakeHead(List value) {
    _snakeHead = value;
    notifyListeners();
  }

  set snakeNeck(List value) {
    _snakeNeck = value;
    notifyListeners();
  }

  set snakeBody(List value) {
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
    // Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    //     _timer = Timer.periodic(
    //       const Duration(milliseconds: 100),
    //       (timer) {
    //         updateMove();
    //       },
    //     );
    //   },
    // );
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
    // if (_snakeHead[0] <= boardSize - _snakePartSize * 3 / 2 && //
    //     _snakeHead[0] >= 0 - _snakePartSize * 3 / 2 && //
    //     _snakeHead[1] <= boardSize - snakePartSize * 3 / 2 && //
    //     _snakeHead[1] >= 0 - _snakePartSize * 3 / 2) {
    //   if (_direction == Direction.down) {
    //     _snakeHead[1] = _snakeHead[1] += 10;
    //   } else if (_direction == Direction.up) {
    //     _snakeHead[1] = _snakeHead[1] -= 10;
    //   } else if (_direction == Direction.right) {
    //     _snakeHead[0] = _snakeHead[0] += 10;
    //   } else if (_direction == Direction.down) {
    //     _snakeHead[0] = _snakeHead[0] -= 10;
    //   }
    // } else {
    //   _timer.cancel();
    //   print("============ NABRAK ===========");
    // }

    notifyListeners();
  }

  void addLength() {
    _snakeLength++;
  }

  void turnRight() {}

  void turnLeft() {}

  void turnUp() {}

  void turnDown() {}
}
