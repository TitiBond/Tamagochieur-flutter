import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tamagochieur/components/needs_icon.dart';
import 'package:tamagochieur/components/progress_bar.dart';
import 'package:tamagochieur/models/need.dart';

class TamagoNeedsTile extends StatefulWidget {
  final NeedsType needType;
  final double progress;
  final double progressWidth;
  final GlobalKey progressBarKey;
  final bool Function() onTap;
  const TamagoNeedsTile({
    super.key,
    required this.needType,
    required this.progress,
    required this.progressBarKey,
    required this.progressWidth,
    required this.onTap,
  });

  @override
  State<TamagoNeedsTile> createState() => _TamagoNeedsTileState();
}

class _TamagoNeedsTileState extends State<TamagoNeedsTile> {
  double scale = 1;
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    void changeScale() {
      if (!isButtonPressed) {
        const timer = Duration(milliseconds: 121);
        setState(() {
          isButtonPressed = !isButtonPressed;
          scale = scale == 1 ? 0.9 : 1;
        });
        Timer(timer, () {
          setState(() {
            scale = scale == 1 ? 0.9 : 1;
          });
          Timer(timer * 2, () {
            isButtonPressed = !isButtonPressed;
          });
        });
      }
    }

    return GestureDetector(
      onTap: () {
        var x = widget.onTap();
        if (x && !isButtonPressed) {
          changeScale();
        }
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
