import 'package:flutter/material.dart';
import 'package:tamagochieur/components/needs_icon.dart';
import 'package:tamagochieur/components/progress_bar.dart';
import 'package:tamagochieur/models/need.dart';

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
