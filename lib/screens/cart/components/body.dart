import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../db/database.dart';
import '../../../models/my_db_model.dart';
import '../../../util/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  List<Cart> cartList;

  Body({required this.cartList});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: ListView.builder(
        itemCount: widget.cartList.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.cartList[index].id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              await MyDatabase.instance.delete(widget.cartList[index].id!);
              widget.cartList.removeAt(index);
              print(widget.cartList[index].id!);
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: widget.cartList[index]),
          ),
        ),
      ),
    );
  }
}
