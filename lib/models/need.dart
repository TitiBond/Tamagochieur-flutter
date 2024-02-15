import 'package:flutter/material.dart';

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

  static Widget getSvg(NeedsType type, double size) {
    switch (type) {
      case NeedsType.drink:
        return Icon(
          Icons.water_drop_outlined,
          color: Colors.white,
          size: size,
        );
      case NeedsType.sleep:
        return Icon(
          Icons.bedtime_outlined,
          color: Colors.white,
          size: size,
        );
      case NeedsType.hug:
        return Icon(
          Icons.favorite_outline,
          color: Colors.white,
          size: size,
        );
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
