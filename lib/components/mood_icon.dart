import 'package:flutter/material.dart';
import 'package:tamagochieur/models/mood.dart';

class TamagoMoodIcon extends StatelessWidget {
  final MoodEnum mood;
  final double size;
  const TamagoMoodIcon({super.key, required this.mood, required this.size});

  @override
  Widget build(BuildContext context) {
    Color moodTileColor = Mood.getColor(mood);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: moodTileColor, borderRadius: BorderRadius.circular(8)),
      child: Mood.getIcon(mood, size),
    );
  }
}
