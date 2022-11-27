import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_history_screen/components/items_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: ItemsCard(),
    );
  }
}
