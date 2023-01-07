import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../util/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth - 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "HAYAT",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.black),
        )
        // TextField(
        //   onChanged: (value) => print(value),
        //   decoration: InputDecoration(
        //       contentPadding: EdgeInsets.symmetric(
        //           horizontal: getProportionateScreenWidth(20),
        //           vertical: getProportionateScreenWidth(9)),
        //       border: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //       enabledBorder: InputBorder.none,
        //       hintText: "Search product",
        //       prefixIcon: Icon(Icons.search)),
        // ),
        );
  }
}
