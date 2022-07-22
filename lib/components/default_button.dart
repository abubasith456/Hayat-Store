import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../util/size_config.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key? key,
    this.text,
    required this.isLoading,
    required this.isEnabled,
    this.press,
  }) : super(key: key);

  final String? text;
  final Function? press;
  final bool isLoading;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: isEnabled! ? kPrimaryColor : Colors.black12,
        ),
        onPressed: isEnabled! ? press as void Function()? : null,
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : AutoSizeText(
                text!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
