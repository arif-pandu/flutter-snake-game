import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class FoodProvider with ChangeNotifier {
  FoodProvider(this.gameProvider);
  final GameProvider gameProvider;

  void spreadFood() {
    List<int> excludeIndex = [];

    excludeIndex.add(gameProvider.snakeHead);
    excludeIndex.add(gameProvider.snakeNeck);

    if (gameProvider.snakeBody.isNotEmpty) {
      for (var item in gameProvider.snakeBody) {
        excludeIndex.add(item);
      }
    }
    createRandomFood(excludeIndex);
  }

  void createRandomFood(List<int> excludeIndex) {
    int randomNum = Random().nextInt(400);

    if (!excludeIndex.contains(randomNum)) {
      gameProvider.food = randomNum;
    } else {
      createRandomFood(excludeIndex);
    }
  }
}
