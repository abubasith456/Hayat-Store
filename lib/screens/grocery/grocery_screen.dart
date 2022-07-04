import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/grocery_bloc/bloc/grocery_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/like_product/cubit/like_product_cubit.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/grocery/components/body.dart';
import 'package:shop_app/util/shimmer.dart';

import '../../util/custom_snackbar.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({Key? key}) : super(key: key);
  static String routeName = "/vegetables";

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
            create: (context) => GroceryBloc()..add(GetGroceryListEvent()),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Grocery',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: BlocConsumer<GroceryBloc, GroceryState>(
                listener: (context, state) {
                  if (state is GroceryErrorState) {
                    showSnackBar(
                        context: context,
                        text: "Something went wrong!...",
                        type: TopSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is GroceryLoadingState) {
                    return shimmerListWidget(context);
                  } else if (state is GroceryLoadedState) {
                    return SafeArea(
                      child: BlocProvider(
                        create: (context) => LikeProductCubit(),
                        child: Body(
                          groceryItems: state.groceryModel,
                        ),
                      ),
                    );
                  } else {
                    return shimmerListWidget(context);
                  }
                },
              ),
            ),
          );
        } else {
          return ConnectionLostScreen();
        }
      },
    );
  }
}
