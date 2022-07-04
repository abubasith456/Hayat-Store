import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSnackBar(
    {required BuildContext context,
    required String text,
    required TopSnackBarType type}) {
  switch (type) {
    case TopSnackBarType.success:
      return showTopSnackBar(
        context,
        CustomSnackBar.success(
          icon: Icon(
            Icons.sentiment_satisfied_alt_outlined,
            color: const Color(0x15000000),
            size: 120,
          ),
          message: text,
        ),
      );

    case TopSnackBarType.error:
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          icon: Icon(
            Icons.sentiment_dissatisfied_outlined,
            color: const Color(0x15000000),
            size: 120,
          ),
          message: text,
        ),
      );

    case TopSnackBarType.info:
      return showTopSnackBar(
        context,
        CustomSnackBar.info(
          icon: Icon(
            Icons.sentiment_satisfied,
            color: const Color(0x15000000),
            size: 120,
          ),
          message: text,
        ),
      );
  }
}
