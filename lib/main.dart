import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/food_provider.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:flutter_snake_game/provider/snake_provider.dart';
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
        ChangeNotifierProvider<GameProvider>(create: (context) => GameProvider()),
        ChangeNotifierProxyProvider<GameProvider, SnakeProvider>(
          create: (context) => SnakeProvider(Provider.of<GameProvider>(context, listen: false)),
          update: (context, gameProvider, coordinates) => SnakeProvider(gameProvider),
        ),
        ChangeNotifierProxyProvider<GameProvider, FoodProvider>(
          create: (context) => FoodProvider(Provider.of<GameProvider>(context, listen: false)),
          update: (context, gameProvider, coordinates) => FoodProvider(gameProvider),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const HomePage(),
          "/play": (context) => const GamePlay(),
        },
      ),
    );
  }
}
