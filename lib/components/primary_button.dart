import 'package:flutter/material.dart';

class TamagoPrimaryButton extends StatelessWidget {
  final String buttonText;
  final double buttonOpacity;
  final void Function()? onTap;
  const TamagoPrimaryButton(
      {super.key,
      required this.buttonText,
      required this.buttonOpacity,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    double buttonBorderRadius = 15;
    Color buttonBackgroundColor = const Color(0xFFEF4562);
    double buttonHorizontalPadding = 32;
    double buttonVerticalPadding = 16;
    double buttonTextSize = 20;
    Color buttonTextColor = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: buttonOpacity,
        curve: Curves.easeIn,
        duration: const Duration(seconds: 1),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
              color: buttonBackgroundColor),
          child: Text(
            buttonText.toUpperCase(),
            style: TextStyle(fontSize: buttonTextSize, color: buttonTextColor),
          ),
        ),
      ),
    );
  }
}
