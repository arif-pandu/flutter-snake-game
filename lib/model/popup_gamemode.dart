import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

popUpChooseMode(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: AppColor.accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<GameProvider>(
                  builder: (context, game, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            game.sensivity = 0.5;
                            Navigator.of(context).pushReplacementNamed("/play");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.primaryColor),
                            child: const Center(
                              child: Text(
                                "SENSITIVE",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            game.sensivity = 1.0;
                            Navigator.of(context).pushReplacementNamed("/play");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.primaryColor),
                            child: const Center(
                              child: Text(
                                "NORMAL",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            game.sensivity = 1.5;
                            Navigator.of(context).pushReplacementNamed("/play");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.primaryColor),
                            child: const Center(
                              child: Text(
                                "CRAZY",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
