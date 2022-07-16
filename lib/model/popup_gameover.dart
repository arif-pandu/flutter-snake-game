import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_game/helper/color.dart';
import 'package:flutter_snake_game/provider/game_provider.dart';
import 'package:provider/provider.dart';

popUpGameOver(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "GAMEOVER",
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Consumer<GameProvider>(
                              builder: (context, game, child) {
                                return Text(
                                  "Score : " + game.snakeLength.toString(),
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.primaryColor),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Consumer<GameProvider>(
                              builder: (context, game, child) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.popAndPushNamed(context, "/");
                                    game.resetLastPlayData();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9.5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.primaryColor,
                                    ),
                                    child: Text(
                                      "HOME",
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
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.primaryColor,
                              ),
                              child: Text(
                                "RESTART",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // child: Center(
            //   child: Container(
            //     constraints: BoxConstraints(
            //       maxHeight: 300,
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("GAMEOVER"),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             Container(
            //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9.5),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 color: AppColor.primaryColor,
            //               ),
            //               child: Text(
            //                 "HOME",
            //                 style: TextStyle(
            //                   fontSize: 18,
            //                   color: AppColor.accentColor,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9.5),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 color: AppColor.primaryColor,
            //               ),
            //               child: Text(
            //                 "RESTART",
            //                 style: TextStyle(
            //                   fontSize: 18,
            //                   color: AppColor.accentColor,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ),
      );
    },
  );
}
