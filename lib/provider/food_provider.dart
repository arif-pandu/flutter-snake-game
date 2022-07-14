import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';

class FoodProvider with ChangeNotifier {
  FoodProvider(this.gameProvider);
  final GameProvider gameProvider;
}
