import 'package:flutter/material.dart';

void showBottomSheetOrderDetails(
    {required BuildContext context,
    required Widget widget,
    required RichText numProd,
    required RichText totalPrice}) {
  showModalBottomSheet(
      context: context,
      elevation: 20,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: Flex(
            direction: Axis.vertical,
            children: [
              ListTile(
                  trailing: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ) // the arrow back icon
                        ),
                  ),
                  leading: const InkWell(
                      onTap: null,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ) // the arrow back icon
                      ),
                  title: const Center(
                      child: Text(
                    "Details",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ) // Your desired title

                      )),
              SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(alignment: Alignment.topLeft, child: numProd),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Align(alignment: Alignment.topLeft, child: totalPrice),
                  ),
                  widget
                ]),
              ),
            ],
          ),
        );
      });
}
