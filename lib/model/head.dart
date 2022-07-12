import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/enum.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
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

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        animationController.forward();
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        var game = Provider.of<GameController>(context, listen: false);
        game.straightAhead();
        animationController.reverse().then((value) => animationController.forward());
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, game, child) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 0),
          left: game.snakeHead[0],
          top: game.snakeHead[1],
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
