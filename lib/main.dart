import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/util/init_check.dart';
import 'cubit/like_product/cubit/like_product_cubit.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _initialChecking = InitialChecking.instance;
  await _initialChecking.getIsLogged();
  runApp(MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => NetworkBloc()
            ..add(
              ListenConnection(),
            ),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => YourCartScreenCubit()..getCartData(),
        )
      ],
      child: MyApp(
        isLogged: _initialChecking.isLogged,
        isNotFirstLogin: _initialChecking.isNotShowWelcome,
      )));
}
