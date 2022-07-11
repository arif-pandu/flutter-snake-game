import 'package:flutter/material.dart';

class TestHead extends StatefulWidget {
  const TestHead({Key? key}) : super(key: key);

  @override
  State<TestHead> createState() => _TestHeadState();
}

class _TestHeadState extends State<TestHead> with TickerProviderStateMixin {
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
        animationController.reverse().then((value) => animationController.forward());
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            axisAlignment: 1,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
