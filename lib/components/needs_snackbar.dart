import 'package:flutter/material.dart';

class TamagoNeedsSnackbar {
  static SnackBar showTamagoSnackbar(String message) {
    double snackbarMargin = 6;
    Color snackbarBackgroundColor = const Color.fromARGB(255, 98, 21, 15);

    return SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: snackbarMargin, left: snackbarMargin, right: snackbarMargin),
      content: Text(message),
      backgroundColor: snackbarBackgroundColor,
      elevation: 0,
    );
  }
}
