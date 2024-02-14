import 'package:flutter/material.dart';
import 'package:tamagochieur/components/needs_tile.dart';

class TamagoNeedsIcon extends StatelessWidget {
  NeedsType needsType;
  TamagoNeedsIcon({super.key, required this.needsType});

  @override
  Widget build(BuildContext context) {
    double iconBorderRadius = 8;
    double iconSize = 32;
    double iconPadding = 8;

    return Container(
      decoration: BoxDecoration(
          color: NeedsTypeAtr.getColor(needsType),
          borderRadius: BorderRadius.circular(iconBorderRadius)),
      padding: EdgeInsets.all(iconPadding),
      child: SizedBox(
        width: iconSize,
        height: iconSize,
        child: NeedsTypeAtr.getSvg(needsType),
      ),
    );
  }
}
