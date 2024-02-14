import 'package:flutter/material.dart';
import 'package:tamagochieur/components/needs_icon.dart';
import 'package:tamagochieur/components/progress_bar.dart';
import 'package:tamagochieur/components/svg/drink_svg.dart';
import 'package:tamagochieur/components/svg/hug_svg.dart';
import 'package:tamagochieur/components/svg/sleep_svg.dart';

class TamagoNeedsTile extends StatefulWidget {
  final NeedsType needType;
  final double progress;
  final double progressWidth;
  final GlobalKey progressBarKey;
  final void Function(TapUpDetails) onTapUp;
  final void Function(TapDownDetails) onTapDown;
  const TamagoNeedsTile(
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
              color: const Color.fromRGBO(129, 129, 129, 0.25),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              //carré gauche
              TamagoNeedsIcon(needsType: widget.needType),
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

  static String getTipsText(NeedsType type) {
    switch (type) {
      case NeedsType.drink:
        return "Pour donner à boire à votre 'Chieur', pensez à lui redonner de l'eau fraîche.";
      case NeedsType.sleep:
        return "Si votre 'chieur' veut dormir, éteignez la lumière ou mettez lui un drap sur la tête.";
      case NeedsType.hug:
        return "Votre 'chieur' veut un calin ? Caressez lui le haut de la tête.";
    }
  }
}
