import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/yout_cart_bloc/bloc/your_cart_bloc_bloc.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../../cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import '../../../util/size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

YourCartBlocBloc _yourCartBloc = YourCartBlocBloc();

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
    _yourCartBloc.add(GetCartDBEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          SizedBox(
            width: 20,
          ),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Search_Icon.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
          SizedBox(
            width: 20,
          ),
          BlocBuilder<YourCartScreenCubit, YourCartItemCount>(
            builder: (context, state) {
              return IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                press: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                  // context.read<HomeBloc>().close();
                },
                numOfitem: state.item,
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
