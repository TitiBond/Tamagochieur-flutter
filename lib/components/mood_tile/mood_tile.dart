import 'package:flutter/material.dart';
import 'package:tamagochieur/components/svg/bad_mood.dart';
import 'package:tamagochieur/components/svg/happy_mood.dart';
import 'package:tamagochieur/components/svg/neutral_mood.dart';

class TamagoMoodTile extends StatelessWidget {
  MoodEnum mood;
  TamagoMoodTile({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    Color moodTileColor = Mood.getColor(mood);
    double size = 150;
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: moodTileColor, borderRadius: BorderRadius.circular(8)),
      child: Mood.getIcon(mood),
    );
  }
}

enum MoodEnum { bad, neutral, happy }

class Mood {
  static Widget getIcon(MoodEnum mood) {
    switch (mood) {
      case MoodEnum.bad:
        return TamagoBadMoodSvg();
      case MoodEnum.neutral:
        return TamagoNeutralMoodSvg();
      case MoodEnum.happy:
        return TamagoHappyMoodSvg();
    }
  }

  static Color getColor(MoodEnum mood) {
    switch (mood) {
      case MoodEnum.bad:
        return Colors.red;
      case MoodEnum.neutral:
        return Colors.orange[300]!;
      case MoodEnum.happy:
        return Colors.green;
    }
  }
}
