import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/bloc/vegetable_bloc/bloc/vegetable_screen_bloc.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/vegetables/components/body.dart';
import 'package:shop_app/util/shimmer.dart';

import '../../constants.dart';

class VegetableScreen extends StatefulWidget {
  static String routeName = "/vegetables";

  @override
  State<VegetableScreen> createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
              create: (context) =>
                  VegetableScreenBloc()..add(GetVegetablesEvent()),
              child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text('Vegetables',
                        style: TextStyle(color: Colors.black)),
                  ),
                  body: BlocConsumer<VegetableScreenBloc, VegetableScreenState>(
                    listener: (context, state) {
                      if (state is VegetableScreenErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is VegetableScreenLoadingState) {
                        return shimmerListWidget(context);
                      } else if (state is VegetableScreenLoadedState) {
                        return Body(
                          vegetable: state.vegetablesModel,
                        );
                      } else {
                        return shimmerListWidget(context);
                      }
                    },
                  )));
        } else {
          return ConnectionLostScreen();
        }
      },
    );
  }
}
