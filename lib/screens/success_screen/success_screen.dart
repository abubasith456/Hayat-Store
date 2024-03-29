import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/screens/order_history_screen/order_history_screen.dart';

import '../../bloc/yout_cart_bloc/bloc/your_cart_bloc_bloc.dart';

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key}) : super(key: key);

  static String routeName = "/successScreen";

  YourCartBlocBloc _yourCartBloc = YourCartBlocBloc();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: [
            IconButton(
              onPressed: (() {
                Navigator.pop(context);
                _yourCartBloc.add(GetCartDBEvent());
                BlocProvider.of<YourCartScreenCubit>(context)..getCartData();
              }),
              icon: Icon(
                Icons.close,
                size: 24.0,
              ),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  "assets/images/success_tick.png",
                ),
                width: 200,
                height: 200,
              ),
              Text(
                "Order Placed Successfully",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 200,
              ),
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: DefaultButton(
                  text: "Order Details",
                  isLoading: false,
                  isEnabled: true,
                  press: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, OrderHistoryScreen.routeName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

        //  Image(
        //   image: AssetImage(
        //     "assets/images/success_tick.png",
        //   ),
        //   width: 400,
        //   height: 400,
        // ),