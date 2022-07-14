import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, _) {
        return Positioned(
          left: game.food[0],
          top: game.food[1],
          child: SizedBox(
            height: game.snakePartSize,
            width: game.snakePartSize,
            child: Center(
              child: Container(
                height: game.snakePartSize * 0.8,
                width: game.snakePartSize * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red[700],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
