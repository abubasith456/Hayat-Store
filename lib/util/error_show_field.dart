import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/util/size_config.dart';

Padding formErrorText({required String error}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: getProportionateScreenWidth(14),
          width: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
}
