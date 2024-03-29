// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/model/body.dart';

class GameProvider with ChangeNotifier {
  //
  /// ========== Variable ==============
  double _sensivity = 1.0;
  int _duration = 300;
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _boardSize = 0;
  double _snakePartSize = 0.0;
  List<List<Point>> _listCoordinateRaw = [];
  List<Point> _listCoordinate = [];

  int snakeLength = 0;
  List<int> _snakeHistory = [];

  List<double> _gyroscopeValue = [0, 0, 0];

  int food = 19;

  int _snakeHead = 0;
  int _snakeNeck = 0;
  List<int> _snakeBody = [];

  List<SnakeBody> _bodyMember = [];

  int axisIndex = 0;
  bool isNegative = false;
  Direction direction = Direction.idle;
  Direction lastDirection = Direction.idle;
  Alignment _headAlign = Alignment.center;
  Axis _headAxisAlign = Axis.horizontal;

  /// ============= Getter ============
  double get sensivity => _sensivity;
  int get duration => _duration;
  List<double> get gyroscopeValue => _gyroscopeValue;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get boardSize => _boardSize;
  double get snakePartSize => _snakePartSize;
  List<List<Point>> get listCoordinateRaw => _listCoordinateRaw;
  List<Point> get listCoordinate => _listCoordinate;

  List<int> get snakeHistory => _snakeHistory;

  int get snakeHead => _snakeHead;
  int get snakeNeck => _snakeNeck;
  List<int> get snakeBody => _snakeBody;

  List<SnakeBody> get bodyMember => _bodyMember;

  Alignment get headAlign => _headAlign;
  Axis get headAxisAlign => _headAxisAlign;

  /// ========== Setter =============

  set sensivity(double value) {
    _sensivity = value;
    notifyListeners();
  }

  set duration(int value) {
    _duration = value;
    notifyListeners();
  }

  set screenWidth(double value) {
    _screenWidth = value;
    notifyListeners();
  }

  set screenHeight(double value) {
    _screenHeight = value;
    notifyListeners();
  }

  set gyroscopeValue(List<double> value) {
    _gyroscopeValue = value;
    notifyListeners();
  }

  set boardSize(double value) {
    _boardSize = value;
    notifyListeners();
  }

  set snakePartSize(double value) {
    _snakePartSize = value;
    notifyListeners();
  }

  set listCoordinateRaw(List<List<Point>> value) {
    _listCoordinateRaw = value;
    notifyListeners();
  }

  set listCoordinate(List<Point> value) {
    _listCoordinate = value;
    notifyListeners();
  }

  set snakeHistory(List<int> value) {
    _snakeHistory = value;
    notifyListeners();
  }

  set snakeHead(int value) {
    _snakeHead = value;
    notifyListeners();
  }

  set snakeNeck(int value) {
    _snakeNeck = value;
    notifyListeners();
  }

  set snakeBody(List<int> value) {
    _snakeBody = value;
    notifyListeners();
  }

  set bodyMember(List<SnakeBody> value) {
    _bodyMember = value;
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

  /// ======= Void =========== ///

  /// Set all object size (Snake Part, board, screen, and coordinate)
  void setDevSize(double height, double width) {
    screenHeight = height;
    screenWidth = width;
    boardSize = (width - 10) - (_screenWidth % 20);
    snakePartSize = boardSize / 20;
    // _snakeHead = [(_boardSize / 2), (_boardSize / 2) - _snakePartSize];
    listCoordinateRaw = [
      ...List.generate(
        20,
        (indexRow) => [
          ...List.generate(
            20,
            (indexColumn) => Point(
              (snakePartSize * indexColumn),
              (snakePartSize * indexRow),
            ),
            // (indexColumn) => [
            //   (snakePartSize * indexColumn),
            //   (snakePartSize * indexRow),
            // ],
          ),
        ],
      ),
    ];

    for (var item in listCoordinateRaw) {
      for (var innerItem in item) {
        listCoordinate.add(innerItem);
      }
    }
    setInitPoint();

    notifyListeners();

    /// Optional
    print("Screen Size Saved!");
    print("Board : " + _boardSize.toStringAsFixed(2));
    print("Part : " + _snakePartSize.toStringAsFixed(2));
    print("Offset : ${_boardSize / 2}, ${(_boardSize / 2) - _snakePartSize}");
  }

  void setInitPoint() {
    var random = [189, 190, 209, 210];
    int initPoint = random[Random().nextInt(random.length)];

    snakeHead = initPoint;
    snakeNeck = initPoint;
  }

  /// Update Real-Time Gyroscope Value (x, y, z)
  /// X : Vertical panorama photo mode
  /// Y : Horizontal panorama photo mode
  /// Z : Rotating control in car mobile game
  void updateGyro(double x, double y, double z) {
    gyroscopeValue = [x, y, z];
    updateData();
    notifyListeners();
  }

  /// Find The Biggest |Value|
  void updateData() {
    List<double> tempList = [];

    var indexLarge = () {
      for (var i = 0; i < gyroscopeValue.length; i++) {
        tempList.add(gyroscopeValue[i].abs());
      }
      double largest = tempList.reduce(max);

      if (largest >= sensivity) {
        return tempList.indexWhere((element) => element == largest);
      } else {
        return axisIndex;
      }
    }();

    axisIndex = indexLarge;
    checkNegative();
  }

  /// Checking The Axis Direction
  void checkNegative() {
    if (gyroscopeValue[axisIndex] <= 1.0) {
      isNegative = true;
    } else if (gyroscopeValue[axisIndex] >= 1.0) {
      isNegative = false;
    }
    checkDirection();
  }

  /// Decide The Direction
  /// Can't rotate 180 degrees (ex : left-> right)
  /// Only non-opposite direction (ex : up -> right)
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
      print("Why Are You Running");
    }
    notifyListeners();
  }

  void resetLastPlayData() {
    snakeLength = 0;
    snakeHead = 0;
    snakeNeck = 0;
    snakeBody = [];
    snakeHistory = [];
    bodyMember = [];
    axisIndex = 0;
    direction = Direction.idle;
    lastDirection = Direction.idle;
    headAlign = Alignment.center;
    headAxisAlign = Axis.horizontal;
    isNegative = false;
    setInitPoint();
    notifyListeners();
  }
}
