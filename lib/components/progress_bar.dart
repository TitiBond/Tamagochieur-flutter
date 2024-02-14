import 'package:flutter/material.dart';

class TamagoProgressBar extends StatelessWidget {
  double progressWidth;
  Key progressBarKey;
  Color progressBarColor;
  TamagoProgressBar(
      {super.key,
      required this.progressWidth,
      required this.progressBarKey,
      required this.progressBarColor});

  @override
  Widget build(BuildContext context) {
    double progressBarHeight = 12;
    Color progressBarBackgroundColor = this.progressBarColor.withOpacity(0.4);
    double progressBarBorderRadius = 5;

    return Stack(
      children: [
        Container(
          key: progressBarKey,
          width: double.infinity,
          height: progressBarHeight,
          decoration: BoxDecoration(
              color: progressBarBackgroundColor,
              borderRadius: BorderRadius.circular(progressBarBorderRadius)),
        ),
        Container(
            width: progressWidth,
            height: progressBarHeight,
            decoration: BoxDecoration(
                color: progressBarColor,
                borderRadius: BorderRadius.circular(progressBarBorderRadius)))
      ],
    );
  }
}
