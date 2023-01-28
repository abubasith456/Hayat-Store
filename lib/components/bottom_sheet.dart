import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_app/util/size_config.dart';

void showBottomSheetOrderDetails(BuildContext context, Widget widget) {
  showModalBottomSheet(
      context: context,
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      builder: (BuildContext context) {
        return ClipRRect(
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  ListTile(
                      trailing: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ) // the arrow back icon
                            ),
                      ),
                      leading: InkWell(
                          onTap: null,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ) // the arrow back icon
                          ),
                      title: Center(
                          child: Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ) // Your desired title

                          )),
                  widget
                ])));
      });
}
