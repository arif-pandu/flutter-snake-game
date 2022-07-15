import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
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
    duration: const Duration(milliseconds: 500),
    reverseDuration: Duration(seconds: 0),
  );

  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.linear,
  );

  void checkCollision() {
    animationController.reverse();
    animationController.forward();

    var game = Provider.of<GameProvider>(context, listen: false);
    var food = Provider.of<FoodProvider>(context, listen: false);

    List<int> collideBodyIndex = [];
    if (game.snakeBody.isNotEmpty) {
      for (var item in game.snakeBody) {
        collideBodyIndex.add(item);
      }
    }

    if (game.snakeHead == game.food) {
      print("=== MAKAN ! ====");
      food.spreadFood();
    } else if (collideBodyIndex.isNotEmpty && collideBodyIndex.contains(game.snakeHead)) {
      print("=== Nabrak Badan ===");
    }

    // List<double> bodyAndTailX() {
    //   List<double> _temp = [];
    //   for (var item in game.xPart) {
    //     _temp.add(item);
    //   }
    //   _temp.removeWhere((element) => element == game.snakeHead[0]);
    //   return _temp;
    // }

    // List<double> bodyAndTailY() {
    //   List<double> _temp = [];
    //   for (var item in game.yPart) {
    //     _temp.add(item);
    //   }
    //   _temp.removeWhere((element) => element == game.snakeHead[1]);
    //   return _temp;
    // }

    /// ==== Check Collision ====

    // if ((game.snakeHead[0] == game.food[0]) && (game.snakeHead[1] == game.food[1])) {
    //   animationController.forward();
    //   print("====== MAKAN ! =======");
    //   game.addBody();
    //   game.spreadFood();
    // }
    // if ((bodyAndTailX().contains(game.snakeHead[0])) && (bodyAndTailY().contains(game.snakeHead[1]))) {
    //   /// If Head Collide with body or tail
    // } else {
    //   animationController.forward();
    //   // Lurus Terus Pantang Mundur
    // }
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
        return AnimatedPositioned(
          duration: Duration(milliseconds: 0),
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
                axisAlignment: -1,
                child: Container(
                  color: Colors.black,
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
