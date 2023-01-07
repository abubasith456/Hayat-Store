import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';

class ProgressBar {
  BuildContext context;
  ProgressBar({required this.context});
  late ArsProgressDialog progressDialog;

  void showProgress() {
    progressDialog = ArsProgressDialog(context,
        blur: 2,
        dismissable: false,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));

    progressDialog.show(); // show dialog
  }

  void dismissDialog() {
    if (progressDialog.isShowing) {
      progressDialog.dismiss(); //close dialog
    }
  }
}
