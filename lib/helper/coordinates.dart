import 'package:flutter/widgets.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Coordinates {
  // double pixel(BuildContext context) => Provider.of<GameController>(context).snakePartSize;
  List listCoordinates = [
    ...List.generate(
      20,
      (index) => [
        ...List.generate(
          20,
          (indexToo) => indexToo,
        ),
      ],
    ),
  ];
}
