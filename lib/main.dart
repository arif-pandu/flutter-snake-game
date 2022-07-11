import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:flutter_snake_game/screen/gameplay.dart';
import 'package:flutter_snake_game/screen/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const HomePage(),
          // "/": (context) => MyPainter(),
          "/play": (context) => const GamePlay(),
        },
      ),
    );
  }
}
