import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamagochieur/components/progress_bar.dart';
import 'package:tamagochieur/components/svg/drink_svg.dart';
import 'package:tamagochieur/components/svg/hug_svg.dart';
import 'package:tamagochieur/components/svg/sleep_svg.dart';

class TamagoNeedsTile extends StatefulWidget {
  NeedsType needType;
  double progress;
  double progressWidth;
  GlobalKey progressBarKey;
  void Function(TapUpDetails) onTapUp;
  void Function(TapDownDetails) onTapDown;
  TamagoNeedsTile(
      {super.key,
      required this.needType,
      required this.progress,
      required this.progressBarKey,
      required this.progressWidth,
      required this.onTapDown,
      required this.onTapUp});

  @override
  State<TamagoNeedsTile> createState() => _TamagoNeedsTileState();
}

class _TamagoNeedsTileState extends State<TamagoNeedsTile> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    void changeScale() {
      setState(() {
        scale = scale == 1 ? 0.9 : 1;
      });
    }

    return GestureDetector(
      onTapDown: (event) {
        changeScale();
        widget.onTapDown(event);
      },
      onTapUp: (event) {
        changeScale();
        widget.onTapUp(event);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: scale,
        child: Container(
          // width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color.fromRGBO(129, 129, 129, 0.25),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              //carré gauche
              Container(
                decoration: BoxDecoration(
                    color: NeedsTypeAtr.getColor(widget.needType),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: NeedsTypeAtr.getSvg(widget.needType),
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
                        Text(NeedsTypeAtr.getText(widget.needType)),
                        Text('${widget.progress.round()} %')
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //progress  bar
                    TamagoProgressBar(
                      progressBarKey: widget.progressBarKey,
                      progressWidth: widget.progressWidth,
                      progressBarColor: NeedsTypeAtr.getColor(widget.needType),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
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
