import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/db/userDB.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await Firebase.initializeApp();
  var user = await UserDb.instance.readAllUser();
  runApp(
    MultiProvider(
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
        isLogged: user.length != 0 ? true : false,
      ),
    ),
  );
}
