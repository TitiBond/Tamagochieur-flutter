import 'package:flutter/material.dart';
import 'package:tamagochieur/models/need.dart';

class TamagoNeedsIcon extends StatelessWidget {
  final NeedsType needsType;
  const TamagoNeedsIcon({super.key, required this.needsType});

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
        child: NeedsTypeAtr.getSvg(needsType, iconSize),
      ),
    );
  }
}
