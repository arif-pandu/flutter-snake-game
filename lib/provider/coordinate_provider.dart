import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class CoordinateProvider with ChangeNotifier {
  final GameProvider game;

  CoordinateProvider(this.game);

  double get partSize => game.snakePartSize;

  List _listCoordinates() {
    return [
      ...List.generate(
        20,
        (indexRow) => [
          ...List.generate(
            20,
            (indexColumn) => [
              partSize * indexRow,
              partSize * indexColumn,
            ],
          ),
        ],
      ),
    ];
  }

  List get listCoordinates => _listCoordinates();
}
