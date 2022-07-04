import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubit/your_cart/cubit/your_cart_screen_cubit.dart';
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
  void initState() {
    super.initState();
    double totalPrice = 0;
    context.read<YourCartScreenCubit>().getCartData();
    // context
    //     .read<YourCartScreenCubit>()
    //     .currentItemCount(widget.cartList.length);
    // widget.cartList.forEach((element) {
    //   totalPrice +=
    //       double.parse(element.price) * double.parse(element.quantity);
    // });
    // context.read<YourCartScreenCubit>().totalAmountCount(totalPrice);
  }

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
              //Remove from DB
              context
                  .read<YourCartScreenCubit>()
                  .deleteCart(widget.cartList[index].id!);
              // await MyDatabase.instance.delete(widget.cartList[index].id!);
              print(widget.cartList[index].id!);
              widget.cartList.removeAt(index);

              double totalPrice = 0;
              //Remove from state
              // context.read<YourCartScreenCubit>().currentItemcountDecrease(
              //     context.read<YourCartScreenCubit>().state.item);
              // widget.cartList.forEach((element) {
              //   totalPrice += double.parse(element.price) *
              //       double.parse(element.quantity);
              // });
              // context.read<YourCartScreenCubit>().totalAmountCount(totalPrice);
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
