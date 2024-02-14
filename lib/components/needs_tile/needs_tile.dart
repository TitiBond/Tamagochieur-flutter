import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamagochieur/components/progress_bar.dart';
import 'package:tamagochieur/components/svg/drink_svg.dart';
import 'package:tamagochieur/components/svg/hug_svg.dart';
import 'package:tamagochieur/components/svg/sleep_svg.dart';

class TamagoNeedsTile extends StatelessWidget {
  NeedsType needType;
  double progress;
  double progressWidth;
  GlobalKey progressBarKey;
  TamagoNeedsTile(
      {super.key,
      required this.needType,
      required this.progress,
      required this.progressBarKey,
      required this.progressWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[400], borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          //carré gauche
          Container(
            decoration: BoxDecoration(
                color: NeedsTypeAtr.getColor(needType),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 32,
              height: 32,
              child: NeedsTypeAtr.getSvg(needType),
            ),
          ),
          const SizedBox(
            width: 8,
          ),

          //partie droite
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //progress text + %
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(NeedsTypeAtr.getText(needType)),
                    Text('${progress.round()} %')
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                //progress  bar
                TamagoProgressBar(
                  progressBarKey: progressBarKey,
                  progressWidth: progressWidth,
                  progressBarColor: NeedsTypeAtr.getColor(needType),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum NeedsType { drink, sleep, hug }

class NeedsTypeAtr {
  static Color getColor(NeedsType type) {
    switch (type) {
      case NeedsType.drink:
        return Colors.blue;
      case NeedsType.sleep:
        return Colors.purple;
      case NeedsType.hug:
        return Colors.red;
    }
  }

  static Widget getSvg(NeedsType type) {
    switch (type) {
      case NeedsType.drink:
        return TamagoDrinkSvg();
      case NeedsType.sleep:
        return TamagoSleepSvg();
      case NeedsType.hug:
        return TamagoHugSvg();
    }
  }

  static String getText(NeedsType type) {
    switch (type) {
      case NeedsType.drink:
        return "Drink Progress";
      case NeedsType.sleep:
        return "Sleep Progress";
      case NeedsType.hug:
        return "Hug Progress";
    }
  }
}
