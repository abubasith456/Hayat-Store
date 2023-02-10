import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'dart:io' show Platform;

class CustomDialog {
  BuildContext context;
  CustomDialog({required this.context});

  late StylishDialog? progressDialog;

  showProgressDialog(String message, String title, bool dismissOnTouchOutside,
      {required StylishDialogType alertType}) {
    if (alertType == StylishDialogType.PROGRESS) {
      progressDialog = StylishDialog(
          context: context,
          dismissOnTouchOutside: dismissOnTouchOutside,
          alertType: alertType,
          content: Text(message));
    } else if (alertType == StylishDialogType.ERROR) {
      progressDialog = StylishDialog(
          alertType: alertType,
          context: context,
          dismissOnTouchOutside: false,
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ));
    }
    progressDialog!.show();
  }

  static showConfirmDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required Function negativeCallback,
      required Function possitiveCallback,
      required String positiveText,
      required String negativeText,
      required PanaraDialogType dialogType}) {
    PanaraConfirmDialog.show(
      context,
      title: title,
      message: message,
      confirmButtonText: positiveText,
      cancelButtonText: negativeText,
      onTapCancel: negativeCallback as void Function(),
      onTapConfirm: possitiveCallback as void Function(),
      panaraDialogType: dialogType,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }

  static showAlertDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required Function possitiveCallback,
      required String positiveText,
      required PanaraDialogType dialogType}) {
    PanaraInfoDialog.show(context,
        message: message,
        buttonText: positiveText,
        barrierDismissible: false,
        onTapDismiss: possitiveCallback as void Function(),
        panaraDialogType: dialogType);
  }


  void dismissDialog() {
    if (progressDialog != null) {
      progressDialog!.dismiss();
    }
  }
}
