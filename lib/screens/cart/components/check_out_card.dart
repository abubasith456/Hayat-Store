import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/order_bloc/bloc/order_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/screens/success_screen/success_screen.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/notification/notification.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

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
            SizedBox(height: getProportionateScreenHeight(20)),
            BlocBuilder<YourCartScreenCubit, YourCartItemCount>(
              builder: (context, state) {
                totalAmount = state.totalAmount.toInt();
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
                              customDialog.showProgressDialog(
                                  "Please wait...", "", false,
                                  alertType: StylishDialogType.PROGRESS);
                            }

                            if (state is OrderPlaced) {
                              customDialog.dismissDialog();
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, SuccessScreen.routeName);
                              MyDatabase.instance.deleteTable();
                            }

                            if (state is OrderErrorState) {
                              customDialog.dismissDialog();
                              showSnackBar(
                                  context: context,
                                  text: "Something went wrong...",
                                  type: TopSnackBarType.error);
                            }
                          },
                          builder: ((context, state) {
                            return DefaultButton(
                              isEnabled:
                                  !widget.cartList.isEmpty ? true : false,
                              text: "Check Out",
                              isLoading: false,
                              press: () {
                                debugPrint(sl<SharedPrefService>()
                                    .getData(userIdKey)
                                    .toString());
                                if (!widget.cartList.isEmpty) {
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
                                          totalAmount: totalAmount));
                                  //To refresh the car items after confirm the order
                                  context
                                      .read<YourCartScreenCubit>()
                                      .getCartData();
                                }
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
