import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tamagochieur/components/needs_tile/needs_tile.dart';

class TamagoHomeScreen extends StatefulWidget {
  const TamagoHomeScreen({super.key});

  @override
  State<TamagoHomeScreen> createState() => _TamagoHomeScreenState();
}

class _TamagoHomeScreenState extends State<TamagoHomeScreen> {
  GlobalKey drinkProgressBarKey = GlobalKey();
  GlobalKey sleepProgressBarKey = GlobalKey();
  GlobalKey hugProgressBarKey = GlobalKey();
  double drinkProgress = 70;
  double sleepProgress = 25.444;
  double hugProgress = 49.5;
  double drinkProgressWidth = 0;
  double sleepProgressWidth = 0;
  double hugProgressWidth = 0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 100), () {
      if (drinkProgressBarKey.currentContext != null) {
        setState(() {
          drinkProgressWidth = (drinkProgressBarKey.currentContext
                      ?.findRenderObject() as RenderBox)
                  .size
                  .width *
              drinkProgress /
              100;
          sleepProgressWidth = (sleepProgressBarKey.currentContext
                      ?.findRenderObject() as RenderBox)
                  .size
                  .width *
              sleepProgress /
              100;
          hugProgressWidth = (hugProgressBarKey.currentContext
                      ?.findRenderObject() as RenderBox)
                  .size
                  .width *
              hugProgress /
              100;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.yellow[100]!,
                  Colors.yellow[300]!,
                  Colors.yellow[500]!,
                ])),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TamagoNeedsTile(
                    needType: NeedsType.drink,
                    progress: drinkProgress,
                    progressWidth: drinkProgressWidth,
                    progressBarKey: drinkProgressBarKey,
                  ),
                  TamagoNeedsTile(
                    needType: NeedsType.sleep,
                    progress: sleepProgress,
                    progressWidth: sleepProgressWidth,
                    progressBarKey: sleepProgressBarKey,
                  ),
                  TamagoNeedsTile(
                    needType: NeedsType.hug,
                    progress: hugProgress,
                    progressWidth: hugProgressWidth,
                    progressBarKey: hugProgressBarKey,
                  )
                ],
              ),
            )));
  }
}
