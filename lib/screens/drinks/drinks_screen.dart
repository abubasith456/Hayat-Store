import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/drinks_bloc/bloc/drinks_bloc.dart';
import 'package:shop_app/bloc/grocery_bloc/bloc/grocery_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/drinks/components/body.dart';
import 'package:shop_app/util/shimmer.dart';
import '../../util/custom_snackbar.dart';

class DrinksScreen extends StatefulWidget {
  const DrinksScreen({Key? key}) : super(key: key);
  static String routeName = "/vegetables";

  @override
  State<DrinksScreen> createState() => _DrinksScreenState();
}

class _DrinksScreenState extends State<DrinksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
            create: (context) => DrinksBloc()..add(GetDrinksListEvent()),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Drinks',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: BlocConsumer<DrinksBloc, DrinksState>(
                listener: (context, state) {
                  if (state is DrinksErrorState) {
                    showSnackBar(
                        context: context,
                        text: "Something went wrong!...",
                        type: TopSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is DrinksLoadingState) {
                    return shimmerListWidget(context);
                  } else if (state is DrinksLoadedState) {
                    return SafeArea(
                      child: Body(
                        drinksItems: state.drinksModel,
                      ),
                    );
                  } else {
                    return shimmerListWidget(context);
                  }
                },
              ),
            ),
          );
        } else if (state is ConnectionFailure) {
          return ConnectionLostScreen();
        } else {
          return Container();
        }
      },
    );
  }
}
