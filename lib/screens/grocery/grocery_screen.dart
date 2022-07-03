import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/grocery_bloc/bloc/grocery_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/grocery/components/body.dart';

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
                    showSnackBar(context, "Something went wrong!...",
                        TopSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is GroceryLoadingState) {
                    return shimmerWidget(context);
                  } else if (state is GroceryLoadedState) {
                    return SafeArea(
                      child: Body(
                        groceryItems: state.groceryModel,
                      ),
                    );
                  } else {
                    return shimmerWidget(context);
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

  Widget shimmerWidget(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            addAutomaticKeepAlives: true,
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 4
                    : 2,
            children: List.generate(10, (index) {
              return Padding(
                padding: const EdgeInsets.all(3),
                child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          textColor: Colors.black,
                          title: Text("Loading"),
                          subtitle: Text("Rs.0"),
                          trailing: Icon(Icons.favorite_outline),
                        ),
                        SizedBox(height: 130, width: 130, child: SizedBox())
                      ],
                    )),
              );
            }),
          ),
        ));
  }
}
