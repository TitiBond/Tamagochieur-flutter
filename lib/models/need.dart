import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  static String getTileText(NeedsType type) {
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

  static Positioned getAnimation(NeedsType type, AnimationController controller,
      Offset position, bool isAction) {
    switch (type) {
      case NeedsType.drink:
        return Positioned(
            top: position.dy - (isAction ? 100 : 50),
            left: -20,
            child: Lottie.asset(
              'assets/animations/${isAction ? "water.json" : 'prout.json'}',
              controller: controller,
              width: 150,
            ));
      case NeedsType.sleep:
        return Positioned(
            top: position.dy - 50,
            left: isAction ? 0 : -20,
            child: Lottie.asset(
              'assets/animations/${isAction ? 'zzz.json' : 'prout.json'}',
              controller: controller,
              width: 150,
            ));
      case NeedsType.hug:
        return Positioned(
            top: position.dy - (isAction ? 255 : 55),
            left: isAction ? 0 : -20,
            child: Lottie.asset(
                'assets/animations/${isAction ? 'love.json' : 'prout.json'}',
                controller: controller,
                width: isAction ? null : 150));
    }
  }

  static String getSnackbarText(NeedsType type) {
    switch (type) {
      case NeedsType.drink:
        return "J'ai pas soif !";
      case NeedsType.sleep:
        return "J'ai pas envie de dormir.";
      case NeedsType.hug:
        return "Me touche pas !";
    }
  }

  static Text getNeedText(NeedsType type) {
    TextStyle style = const TextStyle(fontSize: 16);
    switch (type) {
      case NeedsType.drink:
        return Text(
          "J'ai soif.",
          style: style,
        );
      case NeedsType.sleep:
        return Text(
          "ZzZ  J'ai envie de dormir. zzZ",
          style: style,
        );
      case NeedsType.hug:
        return Text("Tu veux me faire un bisous ?", style: style);
    }
  }
}
