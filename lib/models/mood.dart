import 'package:flutter/material.dart';

enum MoodEnum { veryBad, bad, neutral, happy, veryHappy }

class Mood {
  static Widget getIcon(MoodEnum mood, double size) {
    switch (mood) {
      case MoodEnum.veryBad:
        return Icon(
          Icons.sentiment_very_dissatisfied_outlined,
          color: Colors.white,
          size: size,
        );
      case MoodEnum.bad:
        return Icon(
          Icons.sentiment_dissatisfied_outlined,
          color: Colors.white,
          size: size,
        );
      case MoodEnum.neutral:
        return Icon(
          Icons.sentiment_neutral_outlined,
          color: Colors.white,
          size: size,
        );
      case MoodEnum.happy:
        return Icon(
          Icons.sentiment_satisfied_outlined,
          color: Colors.white,
          size: size,
        );
      case MoodEnum.veryHappy:
        return Icon(
          Icons.sentiment_very_satisfied_outlined,
          color: Colors.white,
          size: size,
        );
    }
  }

  static Color getColor(MoodEnum mood) {
    switch (mood) {
      case MoodEnum.veryBad:
        return const Color.fromARGB(255, 98, 21, 15);
      case MoodEnum.bad:
        return Colors.red;
      case MoodEnum.neutral:
        return Colors.orange[400]!;
      case MoodEnum.happy:
        return Colors.green[300]!;
      case MoodEnum.veryHappy:
        return Colors.green;
    }
  }
}
