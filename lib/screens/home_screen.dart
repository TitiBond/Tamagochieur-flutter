import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tamagochieur/components/draggable_scrollable_sheet.dart';
import 'package:tamagochieur/components/mood_icon.dart';
import 'package:tamagochieur/components/needs_tile.dart';
import 'package:tamagochieur/utils/mqtt_server_client.dart';

class TamagoHomeScreen extends StatefulWidget {
  const TamagoHomeScreen({super.key});

  @override
  State<TamagoHomeScreen> createState() => _TamagoHomeScreenState();
}

class _TamagoHomeScreenState extends State<TamagoHomeScreen> {
  //global mood
  MoodEnum mood = MoodEnum.neutral;
  Color screenAnimatedBackgroundColor = Colors.yellow[500]!;

  //drink
  GlobalKey drinkProgressBarKey = GlobalKey();
  double drinkProgress = 0;
  double drinkProgressWidth = 0;
  bool drinkAction = false;

  //sleep
  GlobalKey sleepProgressBarKey = GlobalKey();
  double sleepProgress = 0;
  double sleepProgressWidth = 0;
  bool sleepAction = false;

  //hug
  GlobalKey hugProgressBarKey = GlobalKey();
  double hugProgress = 0;
  double hugProgressWidth = 0;
  bool hugAction = false;

  bool _isThereAction = false;

  Mqtt mqttHandler = Mqtt();

  @override
  void initState() {
    super.initState();
    mqttHandler.connectToMqtt(getSubscribeValue);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              isScrollControlled: true,
              context: context,
              builder: (context) => const TamagoDraggableScrollableSheet(),
            );
          },
          child: const Icon(Icons.question_mark),
        ),
        body: AnimatedContainer(
            duration: const Duration(seconds: 2),
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  screenAnimatedBackgroundColor,
                  Colors.yellow[100]!,
                  Colors.yellow[300]!,
                  screenAnimatedBackgroundColor
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
                            child: TamagoMoodIcon(
                          mood: mood,
                          size: 150,
                        )),
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
                          TamagoNeedsTile(
                            needType: NeedsType.drink,
                            progress: drinkProgress,
                            progressWidth: drinkProgressWidth,
                            progressBarKey: drinkProgressBarKey,
                            onTapDown: (p0) {
                              drinkAction
                                  ? mqttHandler.publishData("thirst")
                                  : null;
                            },
                            onTapUp: (p0) {},
                          ),
                          TamagoNeedsTile(
                            needType: NeedsType.sleep,
                            progress: sleepProgress,
                            progressWidth: sleepProgressWidth,
                            progressBarKey: sleepProgressBarKey,
                            onTapDown: (p0) {
                              sleepAction
                                  ? mqttHandler.publishData("sleepy")
                                  : null;
                            },
                            onTapUp: (p0) {},
                          ),
                          TamagoNeedsTile(
                            needType: NeedsType.hug,
                            progress: hugProgress,
                            progressWidth: hugProgressWidth,
                            progressBarKey: hugProgressBarKey,
                            onTapDown: (p0) {
                              hugAction
                                  ? mqttHandler.publishData("affection")
                                  : null;
                            },
                            onTapUp: (p0) {},
                          )
                        ]),
                  )
                ],
              ),
            )));
  }
}
