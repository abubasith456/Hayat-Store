import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shop_app/bloc/oder_history_bloc/bloc/order_history_bloc.dart';
import 'package:shop_app/components/bottom_sheet.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/screens/order_history_screen/components/items_card.dart';
import 'package:shop_app/screens/order_history_screen/details_screen.dart';
import 'package:shop_app/util/adaptive_dialog.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:shop_app/util/size_config.dart';

class Body extends StatelessWidget {
  Body({required this.orderHistory, Key? key}) : super(key: key);

  final List<OrderHistoryModel>? orderHistory;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: orderHistory?.length,
        itemBuilder: ((context, mainIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              animateTrailing: false,
              elevation: 30,
              leading: CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text(orderHistory![mainIndex].numOfItems.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                radius: 30,
              ),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Rs. ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: orderHistory![mainIndex].amount.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Status: ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: orderHistory![mainIndex].status.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: _statusTextColor(
                              orderHistory![mainIndex].status.toString()),
                        )),
                  ],
                ),
              ),
              baseColor: Color.fromARGB(179, 242, 242, 242),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _richTextBuilder(
                          context: context,
                          left: "Order ID: ",
                          right: orderHistory![mainIndex].sId.toString(),
                          fontSize: 12),
                      SizedBox(
                        height: 5,
                      ),
                      _richTextBuilder(
                          context: context,
                          left: "Ordered Date: ",
                          right: orderHistory![mainIndex].createdAt.toString(),
                          fontSize: 12),
                      SizedBox(
                        height: 5,
                      ),
                      _richTextBuilder(
                          context: context,
                          left: "Address: ",
                          right: orderHistory![mainIndex].address.toString(),
                          fontSize: 12),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: _cancelButtonVisiblity(
                                            orderHistory![mainIndex].status!)
                                        ? Colors.red
                                        : Color.fromARGB(255, 197, 197, 197),
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: _cancelButtonVisiblity(
                                      orderHistory![mainIndex].status!)
                                  ? (() {
                                      buildConfirmDialog(
                                          context,
                                          cancelPopupTitle,
                                          cancelPopupMessage,
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                          buttonNoText,
                                          () {
                                            Navigator.of(context).pop();
                                            BlocProvider.of<OrderHistoryBloc>(
                                                    context)
                                                .add(CancelOrderEvent(
                                                    orderId:
                                                        orderHistory![mainIndex]
                                                            .sId!));
                                          },
                                          buttonYesText);
                                    })
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(
                                'Details',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      products:
                                          orderHistory![mainIndex].products!,
                                      totalAmount: orderHistory![mainIndex]
                                          .amount!
                                          .toString(),
                                      noOfProd: orderHistory![mainIndex]
                                          .numOfItems
                                          .toString(),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: _deleteButtonVisibility(
                                            orderHistory![mainIndex].status!)
                                        ? kPrimaryColor
                                        : Color.fromARGB(255, 197, 197, 197),
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: _deleteButtonVisibility(
                                      orderHistory![mainIndex].status!)
                                  ? () {
                                      buildConfirmDialog(
                                          context,
                                          cancelPopupTitle,
                                          cancelPopupMessage,
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                          buttonNoText,
                                          () {
                                            Navigator.of(context).pop();
                                            BlocProvider.of<OrderHistoryBloc>(
                                                    context)
                                                .add(DeleteOrderEvent(
                                                    orderId:
                                                        orderHistory![mainIndex]
                                                            .sId!));
                                          },
                                          buttonYesText);
                                    }
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

MaterialColor _statusTextColor(String value) {
  if (value.contains("Preparing") ||
      value.contains("Packing") ||
      value.contains("preparing")) {
    return Colors.deepPurple;
  } else if (value.contains("Delivered") || value.contains("delivered")) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

bool _cancelButtonVisiblity(String value) {
  if (value.contains("Preparing") ||
      value.contains("Packing") ||
      value.contains("preparing")) {
    return true;
  } else {
    return false;
  }
}

bool _deleteButtonVisibility(String value) {
  if (value == "Cancelled" || value == "cancelled") {
    return true;
  } else {
    return false;
  }
}

RichText _richTextBuilder(
    {required BuildContext context,
    required String left,
    required String right,
    required double fontSize}) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: <TextSpan>[
        TextSpan(
            text: left,
            style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: right,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
            )),
      ],
    ),
  );
}
