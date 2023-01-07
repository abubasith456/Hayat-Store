
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/order_bloc/bloc/order_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/screens/success_screen/success_screen.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/util/custom_dialog.dart';

import '../../../constants.dart';
import '../../../models/my_db_model.dart';
import '../../../services/shared_preferences/shared_pref.dart';
import '../../../util/size_config.dart';

class CheckoutCard extends StatefulWidget {
  final List<Cart> cartList;
  CheckoutCard({Key? key, required this.cartList}) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  late int totalAmount;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomDialog customDialog = CustomDialog(context: context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       height: getProportionateScreenWidth(40),
            //       width: getProportionateScreenWidth(40),
            //       decoration: BoxDecoration(
            //         color: Color(0xFFF5F6F9),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: SvgPicture.asset("assets/icons/receipt.svg"),
            //     ),
            //     Spacer(),
            //     Text("Add voucher code"),
            //     const SizedBox(width: 10),
            //     Icon(
            //       Icons.arrow_forward_ios,
            //       size: 12,
            //       color: kTextColor,
            //     )
            //   ],
            // ),
            SizedBox(height: getProportionateScreenHeight(20)),
            BlocBuilder<YourCartScreenCubit, YourCartItemCount>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: "\Rs.${state.totalAmount}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: getProportionateScreenWidth(190),
                        child: BlocConsumer<OrderBloc, OrderState>(
                          listener: (context, state) {
                            if (state is OrderLoadingState) {
                              customDialog.showProgressDialog();
                            }

                            if (state is OrderPlaced) {
                              customDialog.dismissDialog();
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, SuccessScreen.routeName);
                              MyDatabase.instance.deleteTable();
                            }
                          },
                          builder: ((context, state) {
                            return DefaultButton(
                              isEnabled: true,
                              text: "Check Out",
                              isLoading: false,
                              press: () {
                                debugPrint(sl<SharedPrefService>()
                                    .getData(userIdKey)
                                    .toString());
                                BlocProvider.of<OrderBloc>(context).add(
                                    PlaceTheOrder(
                                        userId: int.parse(
                                            sl<SharedPrefService>()
                                                .getData(userIdKey)
                                                .toString()),
                                        name: sl<SharedPrefService>()
                                            .getData(userNameKey)
                                            .toString(),
                                        listOfProducts: widget.cartList,
                                        totalAmount: 100));
                              },
                            );
                          }),
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSuccessSheet(OrderPlaced state, BuildContext context) {
  showBottomSheet(
      context: context,
      builder: ((context) {
        return Container();
      }));
}
