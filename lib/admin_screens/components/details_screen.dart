import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/orders_admin_bloc/bloc/orders_admin_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/screens/order_history_screen/components/items_card.dart';
import 'package:shop_app/util/adaptive_dialog.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({required this.orderModel, Key? key}) : super(key: key);

  final OrderHistoryModel orderModel;
  // final String totalAmount;
  // final String noOfProd;
  static String routeName = "/orderHistory_screen";
  @override
  Widget build(BuildContext context) {
    CustomDialog customDialog = CustomDialog(context: context);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<OrdersAdminBloc, OrdersAdminState>(
        listener: (context, state) {
          if (state is DeliveredOrderSuccess) {
            customDialog.dismissDialog();
            Navigator.of(context).pop();
          } else if (state is DeliveringOrder) {
            customDialog.showProgressDialog(pleaseWait, "", false,
                alertType: StylishDialogType.PROGRESS);
          } else if (state is DeliveringError) {
            showAdaptiveAlertDialog(context, exceptinTitle, state.error, () {
              Navigator.of(context).pop();
              // Will add cancel order api
            }, buttonOkText);
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Details',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: _richTextBuilder(
                            context: context,
                            left: "Number of products: ",
                            right: orderModel.numOfItems.toString(),
                            fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: _richTextBuilder(
                            context: context,
                            left: "Total amount: ",
                            right: orderModel.amount.toString(),
                            fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        itemCount: orderModel.products!.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 30, top: 8, left: 8, right: 8),
                              child: ItemsCard(
                                products: orderModel.products![index],
                              ),
                            ),
                          );
                        })),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Stack(children: [
              Container(
                height: 80,
                padding: const EdgeInsets.all(10),
                child: DefaultButton(
                  isEnabled: orderModel.status == "Preparing" ? true : false,
                  isLoading: false,
                  text: "Delivered",
                  press: () {
                    BlocProvider.of<OrdersAdminBloc>(context).add(
                        DeliveredOrderEvent(
                            orderId: orderModel.sId.toString(),
                            userId: orderModel.uniqueId.toString()));
                  },
                ),
              ),
            ])),
      ),
    );
  }
}

_richTextBuilder(
    {required BuildContext context,
    required String left,
    required String right,
    required double fontSize}) {
  return Text.rich(
    TextSpan(
      text: left,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
      children: [
        TextSpan(
            //Number of item
            text: right,
            style: Theme.of(context).textTheme.titleLarge),
      ],
    ),
  );
}
