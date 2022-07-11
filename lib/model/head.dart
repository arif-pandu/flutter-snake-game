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
      Duration(seconds: 2),
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
            child: () {
              if (game.axisIndex == 0) {
                return Row(
                  mainAxisAlignment: game.isNegative ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.vertical,
                      axisAlignment: 1,
                      child: Container(
                        color: Colors.black,
                        height: game.snakePartSize,
                        width: game.snakePartSize,
                      ),
                    ),
                  ],
                );
              } else if (game.axisIndex == 1) {
                return Column(
                  mainAxisAlignment: game.isNegative ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      axisAlignment: 1,
                      child: Container(
                        color: Colors.black,
                        height: game.snakePartSize,
                        width: game.snakePartSize,
                      ),
                    ),
                  ],
                );
              }
            }(),
          ),
        );
      },
    );
  }
}
