import 'package:flutter/material.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class CustomDialog {
  BuildContext context;
  CustomDialog({required this.context});

  late StylishDialog progressDialog;

  void showProgressDialog() {
    progressDialog =
        StylishDialog(context: context, alertType: StylishDialogType.PROGRESS);

    progressDialog.show();
  }

  void dismissDialog() {
    if (progressDialog != null) {
      progressDialog.dismiss();
    }
  }
}
