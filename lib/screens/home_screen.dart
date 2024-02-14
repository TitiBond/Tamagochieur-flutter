import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tamagochieur/components/mood_tile/mood_tile.dart';
import 'package:tamagochieur/components/needs_tile/needs_tile.dart';

class TamagoHomeScreen extends StatefulWidget {
  const TamagoHomeScreen({super.key});

  @override
  State<TamagoHomeScreen> createState() => _TamagoHomeScreenState();
}

class _TamagoHomeScreenState extends State<TamagoHomeScreen> {
  //drink
  GlobalKey drinkProgressBarKey = GlobalKey();
  double drinkProgress = 70;
  double drinkProgressWidth = 0;
  double _drinkScale = 1;

  //sleep
  GlobalKey sleepProgressBarKey = GlobalKey();
  double sleepProgress = 25.444;
  double sleepProgressWidth = 0;
  double _sleepScale = 1;

  //hug
  GlobalKey hugProgressBarKey = GlobalKey();
  double hugProgress = 49.5;
  double hugProgressWidth = 0;
  double _hugScale = 1;

  bool _isThereAction = false;

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
            width: double.infinity,
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
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: TamagoMoodTile(mood: MoodEnum.neutral)),
                      )),
                  _isThereAction
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                        )
                      : const SizedBox(
                          height: 25,
                        ),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedScale(
                            scale: _drinkScale == 1 ? 0.9 : 1,
                            duration: const Duration(milliseconds: 100),
                            child: TamagoNeedsTile(
                              needType: NeedsType.drink,
                              progress: drinkProgress,
                              progressWidth: drinkProgressWidth,
                              progressBarKey: drinkProgressBarKey,
                              onTapDown: (p0) {
                                setState(() {
                                  _drinkScale = _drinkScale == 1 ? 0.9 : 1;
                                });
                              },
                              onTapUp: (p0) {
                                setState(() {
                                  _drinkScale = _drinkScale == 1 ? 0.9 : 1;
                                });
                              },
                            ),
                          ),
                          AnimatedScale(
                            scale: _sleepScale == 1 ? 0.9 : 1,
                            duration: const Duration(milliseconds: 100),
                            child: TamagoNeedsTile(
                              needType: NeedsType.sleep,
                              progress: sleepProgress,
                              progressWidth: sleepProgressWidth,
                              progressBarKey: sleepProgressBarKey,
                              onTapDown: (p0) {
                                setState(() {
                                  _sleepScale = _sleepScale == 1 ? 0.9 : 1;
                                });
                              },
                              onTapUp: (p0) {
                                setState(() {
                                  _sleepScale = _sleepScale == 1 ? 0.9 : 1;
                                });
                              },
                            ),
                          ),
                          AnimatedScale(
                              scale: _hugScale == 1 ? 0.9 : 1,
                              duration: const Duration(milliseconds: 100),
                              child: TamagoNeedsTile(
                                needType: NeedsType.hug,
                                progress: hugProgress,
                                progressWidth: hugProgressWidth,
                                progressBarKey: hugProgressBarKey,
                                onTapDown: (p0) {
                                  setState(() {
                                    _hugScale = _hugScale == 1 ? 0.9 : 1;
                                  });
                                },
                                onTapUp: (p0) {
                                  setState(() {
                                    _hugScale = _hugScale == 1 ? 0.9 : 1;
                                  });
                                },
                              ))
                        ]),
                  )
                ],
              ),
            )));
  }
}
