import 'package:flutter/widgets.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Coordinates {
  double partSize(BuildContext context) {
    var game = Provider.of<GameController>(context, listen: false);

    return game.snakePartSize;
  }

  // BIKIN LIST COORDINATES BIAR GAMPANG

  List listCoordinates(BuildContext context) => [
        ...List.generate(
          20,
          (indexRow) => [
            ...List.generate(
              20,
              (indexColumn) => [
                partSize(context) * indexRow,
                partSize(context) * indexColumn,
              ],
            ),
          ],
        ),
      ];
}
