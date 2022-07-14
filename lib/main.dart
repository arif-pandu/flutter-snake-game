import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/coordinate_provider.dart';
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
        ChangeNotifierProxyProvider<GameProvider, CoordinateProvider>(
          create: (context) => CoordinateProvider(Provider.of<GameProvider>(context, listen: false)),
          update: (context, gameProvider, coordinates) => CoordinateProvider(gameProvider),
        ),
        ChangeNotifierProxyProvider<GameProvider, SnakeProvider>(
          create: (context) => SnakeProvider(Provider.of<GameProvider>(context, listen: false)),
          update: (context, gameProvider, coordinates) => SnakeProvider(gameProvider),
        ),
        ChangeNotifierProxyProvider<GameProvider, FoodProvider>(
          create: (context) => FoodProvider(Provider.of<GameProvider>(context, listen: false)),
          update: (context, gameProvider, coordinates) => FoodProvider(gameProvider),
        ),
        // ChangeNotifierProxyProvider3<CoordinateProvider, SnakeProvider, FoodProvider, GameProvider>(
        //   update: (context, value, value2, value3, previous) => GameProvider(),
        //   create: (food) => GameProvider(),
        // ),
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
