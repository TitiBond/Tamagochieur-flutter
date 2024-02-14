import 'package:flutter/material.dart';
import 'package:tamagochieur/components/needs_icon.dart';
import 'package:tamagochieur/components/needs_tile.dart';

class TamagoTipsTile extends StatelessWidget {
  final NeedsType type;
  const TamagoTipsTile({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TamagoNeedsIcon(needsType: type),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            NeedsTypeAtr.getTipsText(type),
          ),
        )
      ],
    );
  }
}
