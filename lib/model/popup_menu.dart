import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

popUpMenu(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: AppColor.accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "BACK TO MENU",
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColor.primaryColor,
                            ),
                            child: const Text(
                              "NO",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColor.accentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Consumer<GameProvider>(
                          builder: (context, game, child) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, "/");
                                game.resetLastPlayData();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.primaryColor,
                                ),
                                child: const Text(
                                  "YES",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.accentColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
