import 'package:flutter/material.dart';
import 'package:shop_app/db/database.dart';

import '../../models/my_db_model.dart';
import '../../util/size_config.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  late List<Cart>? empty;
  Future<List<Cart>> getAllData() async {
    List<Cart> cartList = await MyDatabase.instance.readAllcart();
    print(cartList.length);
    return cartList;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder<List<Cart>>(
      future: getAllData(),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  appBar: buildAppBar(context, snapshot.data!.length),
                  body: Body(cartList: snapshot.data!),
                  bottomNavigationBar: CheckoutCard(
                    cartList: snapshot.data!,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, int length) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              " ${length} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
