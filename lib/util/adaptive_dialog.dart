import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'dart:io' show Platform;

showAdaptiveConfirmDialog(
    BuildContext context,
    String title,
    String body,
    Function onLButtonTap,
    String lButtonTitle,
    Function onRButtonTap,
    String rButtonTitle) {
  return Platform.isIOS
      ? buildCupertinoConfirmDialog(context, title, body, onLButtonTap,
          lButtonTitle, onRButtonTap, rButtonTitle)
      : buildConfirmDialog(context, title, body, onLButtonTap, lButtonTitle,
          onRButtonTap, rButtonTitle);
}

showAdaptiveAlertDialog(BuildContext context, String title, String body,
    Function onLButtonTap, String lButtonTitle) {
  return Platform.isIOS || Platform.isMacOS
      ? buildCupertinoAlertDialog(
          context, title, body, onLButtonTap, lButtonTitle)
      : buildAlertDialog(context, title, body, onLButtonTap, lButtonTitle);
}

buildCupertinoConfirmDialog(
    BuildContext context,
    String title,
    String body,
    Function onLButtonTap,
    String lButtonTitle,
    Function onRButtonTap,
    String rButtonTitle) {
  return showDialog(
      context: context,
      builder: (context) => WillPopScope(
          child: CupertinoAlertDialog(
            title: title != ""
                ? Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Container(),
            content: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onLButtonTap as void Function()?,
                child: Text(
                  lButtonTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: onRButtonTap as void Function()?,
                child: Text(
                  rButtonTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          onWillPop: (() => _willPop())));
}

Future<bool> _willPop() async {
  return false;
}

buildConfirmDialog(
    BuildContext context,
    String title,
    String body,
    Function onLButtonTap,
    String lButtonTitle,
    Function onRButtonTap,
    String rButtonTitle) {
  return showDialog(
    context: context,
    builder: ((context) => WillPopScope(
        onWillPop: (() => _willPop()),
        child: AlertDialog(
          insetPadding: const EdgeInsets.only(left: 80, right: 80, bottom: 12),
          contentPadding:
              const EdgeInsets.only(bottom: 30, top: 20, left: 16, right: 16),
          buttonPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: title != ""
              ? Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Container(),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 197, 197, 197),
                  ),
                ),
                color: Colors.transparent,
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onLButtonTap as void Function()?,
                        child: Text(
                          lButtonTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Color.fromARGB(255, 197, 197, 197),
                      width: 0,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: onRButtonTap as void Function()?,
                        child: Text(
                          rButtonTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ))),
  );
}

buildCupertinoAlertDialog(
  BuildContext context,
  String title,
  String body,
  Function onLButtonTap,
  String lButtonTitle,
) {
  return showDialog(
      context: context,
      builder: (context) => WillPopScope(
          child: CupertinoAlertDialog(
            title: title != ""
                ? Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Container(),
            content: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onLButtonTap as void Function()?,
                child: Text(
                  lButtonTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          onWillPop: (() => _willPop())));
}

buildAlertDialog(
  BuildContext context,
  String title,
  String body,
  Function onLButtonTap,
  String lButtonTitle,
) {
  return showDialog(
    context: context,
    builder: ((context) => WillPopScope(
        onWillPop: (() => _willPop()),
        child: AlertDialog(
          insetPadding: const EdgeInsets.only(left: 80, right: 80, bottom: 12),
          contentPadding:
              const EdgeInsets.only(bottom: 30, top: 20, left: 16, right: 16),
          buttonPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: title != ""
              ? Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Container(),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 197, 197, 197),
                  ),
                ),
                color: Colors.transparent,
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onLButtonTap as void Function()?,
                        child: Text(
                          lButtonTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // VerticalDivider(
                    //   thickness: 1,
                    //   color: Color.fromARGB(255, 197, 197, 197),
                    //   width: 0,
                    // ),
                    // Expanded(
                    //   child: TextButton(
                    //     onPressed: onRButtonTap as void Function()?,
                    //     child: Text(
                    //       rButtonTitle,
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 16.0,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ))),
  );
}
