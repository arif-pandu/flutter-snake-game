// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/model/popup_gameover.dart';
import 'package:flutter_snake_game/provider/food_provider.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:flutter_snake_game/provider/snake_provider.dart';
import 'package:provider/provider.dart';

class SnakeHead extends StatefulWidget {
  const SnakeHead({
    Key? key,
  }) : super(key: key);

  @override
  State<SnakeHead> createState() => _SnakeHeadState();
}

class _SnakeHeadState extends State<SnakeHead> with TickerProviderStateMixin {
  // MAKE NEW ANIMATION
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: context.read<GameProvider>().duration),
    reverseDuration: const Duration(seconds: 0),
  );

  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.linear,
  );

  BorderSide bordered = const BorderSide(width: 1, color: Colors.black87);
  BorderSide nonBorder = const BorderSide(width: 0, color: Colors.transparent);

  Radius rounded = const Radius.circular(5);
  Radius nonRounded = const Radius.circular(0);

  void checkCollision() {
    animationController.forward();

    var game = Provider.of<GameProvider>(context, listen: false);
    var snake = Provider.of<SnakeProvider>(context, listen: false);
    var food = Provider.of<FoodProvider>(context, listen: false);

    List<int> collideBodyIndex = [];
    if (game.snakeBody.isNotEmpty) {
      for (var item in game.snakeBody) {
        collideBodyIndex.add(item);
      }
    }

    /// If Snake Head collide with FOOD or BODY
    if (game.snakeHead == game.food) {
      print("=== EAT FOOD ! ====");
      snake.addBody();
      food.spreadFood();
    } else if (collideBodyIndex.isNotEmpty && collideBodyIndex.contains(game.snakeHead)) {
      animationController.stop();
      popUpGameOver(context);
      print("=== DUARRR !!! ===");
    }
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        animationController.forward();
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          var snake = Provider.of<SnakeProvider>(context, listen: false);
          snake.straightAhead();
          animationController.reverse().then((value) => checkCollision());
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Positioned(
          left: game.listCoordinate[game.snakeHead].x.toDouble(),
          top: game.listCoordinate[game.snakeHead].y.toDouble(),
          child: SizedBox(
            height: game.snakePartSize,
            width: game.snakePartSize,
            child: Align(
              alignment: game.headAlign,
              child: SizeTransition(
                sizeFactor: animation,
                axis: game.headAxisAlign,
                axisAlignment: (game.headAlign == Alignment.centerRight) || (game.headAlign == Alignment.bottomCenter) ? -1 : 1,
                child: Container(
                  color: AppColor.snakeColor,
                  height: game.snakePartSize,
                  width: game.snakePartSize,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
