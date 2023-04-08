import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/oder_history_bloc/bloc/order_history_bloc.dart';
import 'package:shop_app/bloc/orders_admin_bloc/bloc/orders_admin_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/admin_screens/components/details_screen.dart';
import 'package:shop_app/util/adaptive_dialog.dart';

class Body extends StatelessWidget {
  Body({required this.orderHistory, Key? key}) : super(key: key);

  final List<OrderHistoryModel>? orderHistory;
  @override
  Widget build(BuildContext context) {
    bool orderAccepted = false;

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
                radius: 30,
                child: Text(orderHistory![mainIndex].numOfItems.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
              ),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Rs. ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: orderHistory![mainIndex].amount.toString(),
                        style: const TextStyle(
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
                    const TextSpan(
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
                      const SizedBox(
                        height: 10,
                      ),
                      _richTextBuilder(
                          context: context,
                          left: "Order ID: ",
                          right: orderHistory![mainIndex].sId.toString(),
                          fontSize: 12),
                      const SizedBox(
                        height: 5,
                      ),
                      _richTextBuilder(
                          context: context,
                          left: "Ordered Date: ",
                          right: orderHistory![mainIndex].createdAt.toString(),
                          fontSize: 12),
                      const SizedBox(
                        height: 5,
                      ),
                      _richTextBuilder(
                          context: context,
                          left: "Address: ",
                          right: orderHistory![mainIndex].address.toString(),
                          fontSize: 12),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              backgroundColor: _isOrderNotAcepted(
                                      orderHistory![mainIndex]
                                          .status
                                          .toString())
                                  ? Colors.green
                                  : const Color.fromARGB(255, 197, 197, 197),
                              onPressed: () {
                                _isOrderNotAcepted(orderHistory![mainIndex]
                                        .status
                                        .toString())
                                    ? BlocProvider.of<OrdersAdminBloc>(context)
                                        .add(AcceptOrderEvent(
                                            orderId: orderHistory![mainIndex]
                                                .sId
                                                .toString(),
                                            userId: orderHistory![mainIndex]
                                                .uniqueId
                                                .toString()))
                                    : null;
                              },
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),

                          Expanded(
                              child: SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              backgroundColor: _isPreparingBtnVisiblity(
                                      orderHistory![mainIndex]
                                          .status
                                          .toString())
                                  ? Colors.green
                                  : const Color.fromARGB(255, 197, 197, 197),
                              onPressed: () => _isPreparingBtnVisiblity(
                                      orderHistory![mainIndex]
                                          .status
                                          .toString())
                                  ? BlocProvider.of<OrdersAdminBloc>(context)
                                      .add(PreparingOrderEvent(
                                          orderId: orderHistory![mainIndex]
                                              .sId
                                              .toString(),
                                          userId: orderHistory![mainIndex]
                                              .uniqueId
                                              .toString()))
                                  : null,
                              child: const Text(
                                'Preparing',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),

                          Expanded(
                              child: SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              backgroundColor: Colors.deepPurple,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      orderModel: orderHistory![mainIndex],
                                      // totalAmount: orderHistory![mainIndex]
                                      //     .amount!
                                      //     .toString(),
                                      // noOfProd: orderHistory![mainIndex]
                                      //     .numOfItems
                                      //     .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Details',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),

                          // Expanded(
                          //     child: SizedBox(
                          //   height: 70,
                          //   width: 70,
                          //   child: FloatingActionButton(
                          //     backgroundColor: Colors.red,
                          //     onPressed: () {
                          //       buildConfirmDialog(
                          //           context,
                          //           cancelPopupTitle,
                          //           cancelPopupMessage,
                          //           () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           buttonNoText,
                          //           () {
                          //             Navigator.of(context).pop();
                          //             BlocProvider.of<OrderHistoryBloc>(context)
                          //                 .add(DeleteOrderEvent(
                          //                     orderId: orderHistory![mainIndex]
                          //                         .sId!));
                          //           },
                          //           buttonYesText);
                          //     },
                          //     child: const Text(
                          //       'Cancel',
                          //       style: TextStyle(
                          //           fontSize: 15,
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // )),
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

bool _isOrderNotAcepted(String status) {
  if (status.contains("Pending") || status.contains("pending")) {
    return true;
  } else {
    return false;
  }
}

bool _isPreparingBtnVisiblity(String status) {
  if (status.contains("Pending") ||
      status.contains("pending") ||
      status.contains("Preparing") ||
      status.contains("preparing") ||
      status.contains("Delivered")) {
    return false;
  } else {
    return true;
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
