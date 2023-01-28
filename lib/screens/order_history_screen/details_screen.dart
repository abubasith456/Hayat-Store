import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/screens/order_history_screen/components/items_card.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen(
      {required this.products,
      required this.totalAmount,
      required this.noOfProd,
      Key? key})
      : super(key: key);

  final List<Products> products;
  final String totalAmount;
  final String noOfProd;
  static String routeName = "/orderHistory_screen";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: _richTextBuilder(
                        context: context,
                        left: "Number of products: ",
                        right: noOfProd,
                        fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: _richTextBuilder(
                        context: context,
                        left: "Total amount: ",
                        right: totalAmount,
                        fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 30, top: 8, left: 8, right: 8),
                          child: ItemsCard(
                            products: products[index],
                          ),
                        ),
                      );
                    })),
              ],
            ),
          ),
        ),
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
