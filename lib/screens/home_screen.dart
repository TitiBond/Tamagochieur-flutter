import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tamagochieur/components/draggable_scrollable_sheet.dart';
import 'package:tamagochieur/components/needs_snackbar.dart';
import 'package:tamagochieur/components/needs_tile.dart';
import 'package:tamagochieur/models/mood.dart';
import 'package:tamagochieur/models/need.dart';
import 'package:tamagochieur/utils/mqtt_server_client.dart';

class TamagoHomeScreen extends StatefulWidget {
  const TamagoHomeScreen({super.key});

  @override
  State<TamagoHomeScreen> createState() => _TamagoHomeScreenState();
}

class _TamagoHomeScreenState extends State<TamagoHomeScreen>
    with TickerProviderStateMixin {
  //global mood
  MoodEnum mood = MoodEnum.neutral;
  Color screenAnimatedBackgroundColor = Mood.getColor(MoodEnum.neutral);
  GlobalKey lottieKey = GlobalKey();
  Duration buttonAnimationDuration = const Duration(seconds: 2);

  //drink
  GlobalKey drinkTileKey = GlobalKey();
  Offset? drinkTilePosition;
  late final AnimationController _drinkAnimationController;
  bool isDrinkAnimationOn = false;
  GlobalKey drinkProgressBarKey = GlobalKey();
  double drinkProgress = 0;
  double drinkProgressWidth = 0;
  bool drinkAction = true;

  //sleep
  GlobalKey sleepTileKey = GlobalKey();
  Offset? sleepTilePosition;
  late final AnimationController _sleepAnimationController;
  bool isSleepAnimationOn = false;
  GlobalKey sleepProgressBarKey = GlobalKey();
  double sleepProgress = 0;
  double sleepProgressWidth = 0;
  bool sleepAction = false;

  //hug
  GlobalKey hugTileKey = GlobalKey();
  Offset? hugTilePosition;
  late final AnimationController _hugAnimationController;
  bool isHugAnimationOn = false;
  GlobalKey hugProgressBarKey = GlobalKey();
  double hugProgress = 0;
  double hugProgressWidth = 0;
  bool hugAction = false;

  Mqtt mqttHandler = Mqtt();

  @override
  void initState() {
    super.initState();
    mqttHandler.connectToMqtt(getSubscribeValue);

    _drinkAnimationController =
        AnimationController(vsync: this, duration: buttonAnimationDuration);

    _sleepAnimationController =
        AnimationController(vsync: this, duration: buttonAnimationDuration);

    _hugAnimationController =
        AnimationController(vsync: this, duration: buttonAnimationDuration);

    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        updateNeedValues();
      });
    });
  }

  void updateNeedValues() {
    if (drinkProgressBarKey.currentContext != null) {
      drinkProgressWidth =
          (drinkProgressBarKey.currentContext?.findRenderObject() as RenderBox)
                  .size
                  .width *
              drinkProgress /
              100;
      sleepProgressWidth =
          (sleepProgressBarKey.currentContext?.findRenderObject() as RenderBox)
                  .size
                  .width *
              sleepProgress /
              100;
      hugProgressWidth =
          (hugProgressBarKey.currentContext?.findRenderObject() as RenderBox)
                  .size
                  .width *
              hugProgress /
              100;

      drinkTilePosition =
          (drinkTileKey.currentContext?.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);
      sleepTilePosition =
          (sleepTileKey.currentContext?.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);
      hugTilePosition =
          (hugTileKey.currentContext?.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);
    }
  }

  void getSubscribeValue(String value) {
    final values = jsonDecode(value);
    setState(() {
      sleepProgress = values["sleepy"]["value"] + 0.0;
      sleepAction = values["sleepy"]["action"];
      drinkProgress = values["thirst"]["value"] + 0.0;
      drinkAction = values["thirst"]["action"];
      hugProgress = values["affection"]["value"] + 0.0;
      hugAction = values["affection"]["action"];
      final state = values["state"];

      if (state <= 25) {
        mood = MoodEnum.veryBad;
      } else if (state <= 40) {
        mood = MoodEnum.bad;
      } else if (state <= 60) {
        mood = MoodEnum.neutral;
      } else if (state <= 90) {
        mood = MoodEnum.happy;
      } else {
        mood = MoodEnum.veryHappy;
      }
      screenAnimatedBackgroundColor = Mood.getColor(mood);
      updateNeedValues();
    });
  }

  void onClickButton(String value) {
    switch (value) {
      case "thirst":
        if (drinkAction) {
          mqttHandler.publishData(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              TamagoNeedsSnackbar.showTamagoSnackbar(
                  NeedsTypeAtr.getSnackbarText(NeedsType.drink)));
        }
        if (!isDrinkAnimationOn) {
          setState(() {
            _drinkAnimationController.forward();
            isDrinkAnimationOn = !isDrinkAnimationOn;
          });
          Timer(buttonAnimationDuration, () {
            setState(() {
              _drinkAnimationController.reset();
              isDrinkAnimationOn = !isDrinkAnimationOn;
            });
          });
        }
        break;
      case "sleepy":
        if (sleepAction) {
          mqttHandler.publishData(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              TamagoNeedsSnackbar.showTamagoSnackbar(
                  NeedsTypeAtr.getSnackbarText(NeedsType.sleep)));
        }
        if (!isSleepAnimationOn) {
          setState(() {
            _sleepAnimationController.forward();
            isSleepAnimationOn = !isSleepAnimationOn;
          });
          Timer(buttonAnimationDuration, () {
            setState(() {
              _sleepAnimationController.reset();
              isSleepAnimationOn = !isSleepAnimationOn;
            });
          });
        }
        break;
      case "affection":
        if (hugAction) {
          mqttHandler.publishData(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              TamagoNeedsSnackbar.showTamagoSnackbar(
                  NeedsTypeAtr.getSnackbarText(NeedsType.hug)));
        }
        if (!isHugAnimationOn) {
          setState(() {
            _hugAnimationController.forward();
            isHugAnimationOn = !isHugAnimationOn;
          });
          Timer(buttonAnimationDuration, () {
            setState(() {
              _hugAnimationController.reset();
              isHugAnimationOn = !isHugAnimationOn;
            });
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const TamagoDraggableScrollableSheet(),
            );
          },
          child: const Icon(Icons.question_mark),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
                duration: const Duration(seconds: 2),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      screenAnimatedBackgroundColor,
                      screenAnimatedBackgroundColor,
                      Colors.yellow[700]!,
                      Colors.yellow[500]!,
                      Colors.yellow[300]!,
                    ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child: Mood.getIcon(mood, 150)),
                          )),
                      if (drinkAction || sleepAction || hugAction)
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              drinkAction
                                  ? NeedsTypeAtr.getNeedText(NeedsType.drink)
                                  : const SizedBox(),
                              sleepAction
                                  ? NeedsTypeAtr.getNeedText(NeedsType.sleep)
                                  : const SizedBox(),
                              hugAction
                                  ? NeedsTypeAtr.getNeedText(NeedsType.hug)
                                  : const SizedBox(),
                            ],
                          ),
                        )
                      else
                        const SizedBox(
                          height: 25,
                        ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TamagoNeedsTile(
                                key: drinkTileKey,
                                needType: NeedsType.drink,
                                progress: drinkProgress,
                                progressWidth: drinkProgressWidth,
                                progressBarKey: drinkProgressBarKey,
                                onTap: () {
                                  onClickButton("thirst");
                                },
                              ),
                              TamagoNeedsTile(
                                key: sleepTileKey,
                                needType: NeedsType.sleep,
                                progress: sleepProgress,
                                progressWidth: sleepProgressWidth,
                                progressBarKey: sleepProgressBarKey,
                                onTap: () {
                                  onClickButton("sleepy");
                                  //  ScaffoldMessenger.of(context)
                                  //     .showSnackBar(TamagoNeedsSnackbar
                                  //         .showTamagoSnackbar(
                                  //             NeedsTypeAtr.getSnackbarText(
                                  //                 NeedsType.sleep)));
                                },
                              ),
                              TamagoNeedsTile(
                                key: hugTileKey,
                                needType: NeedsType.hug,
                                progress: hugProgress,
                                progressWidth: hugProgressWidth,
                                progressBarKey: hugProgressBarKey,
                                onTap: () {
                                  onClickButton("affection");
                                  //  ScaffoldMessenger.of(context)
                                  //     .showSnackBar(TamagoNeedsSnackbar
                                  //         .showTamagoSnackbar(
                                  //             NeedsTypeAtr.getSnackbarText(
                                  //                 NeedsType.hug)));
                                },
                              )
                            ]),
                      )
                    ],
                  ),
                )),
            if (isDrinkAnimationOn)
              NeedsTypeAtr.getAnimation(NeedsType.drink,
                  _drinkAnimationController, drinkTilePosition!, drinkAction)
            else
              const SizedBox(),
            if (isSleepAnimationOn)
              NeedsTypeAtr.getAnimation(NeedsType.sleep,
                  _sleepAnimationController, sleepTilePosition!, sleepAction)
            else
              const SizedBox(),
            if (isHugAnimationOn)
              NeedsTypeAtr.getAnimation(NeedsType.hug, _hugAnimationController,
                  hugTilePosition!, hugAction)
            else
              const SizedBox()
          ],
        ));
  }
}
