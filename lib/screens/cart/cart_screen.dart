import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import '../../models/my_db_model.dart';
import '../../util/size_config.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  late List<Cart>? cartList;

  // Future<List<Cart>> getAllData() async {
  //   List<Cart> cartList = await MyDatabase.instance.readAllcart();
  //   print(cartList.length);
  //   return cartList;
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<YourCartScreenCubit, YourCartItemCount>(
      builder: (context, state) {
        return state.cartList != null
            ? WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  appBar: buildAppBar(context, state.cartList.length),
                  body: Body(cartList: state.cartList),
                  bottomNavigationBar: CheckoutCard(
                    cartList: state.cartList,
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
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: BlocBuilder<YourCartScreenCubit, YourCartItemCount>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Cart",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  " ${state.item} items",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
