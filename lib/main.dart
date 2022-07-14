import 'package:flutter/material.dart';
import 'package:flutter_snake_game/provider/coordinate_provider.dart';
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
        ChangeNotifierProvider<GameController>(create: (context) => GameController()),
        ChangeNotifierProxyProvider<GameController, AreaCoordinate>(
          create: (context) => AreaCoordinate(Provider.of<GameController>(context, listen: false)),
          update: (context, gameController, coordinates) => AreaCoordinate(gameController),
        )
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
