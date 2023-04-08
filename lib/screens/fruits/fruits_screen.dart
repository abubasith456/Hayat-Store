import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/fruit_bloc/bloc/fruits_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/cubit/like_product/cubit/like_product_cubit.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/fruits/components/body.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'package:shop_app/util/shimmer.dart';

import '../../constants.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({Key? key}) : super(key: key);

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
            create: (context) => FruitsBloc()..add(GetFruitsListEvent()),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  'Fruits',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: BlocConsumer<FruitsBloc, FruitsState>(
                listener: (context, state) {
                  if (state is FruitsErrorState) {
                    showSnackBar(
                        context: context,
                        text: "Something went wrong!... Please try again later",
                        type: TopSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is FruitsLoadingState) {
                    return shimmerListWidget(context);
                  } else if (state is FruitsLoadedState) {
                    return SafeArea(
                      child: BlocProvider(
                        create: (context) => LikeProductCubit(),
                        child: Body(
                          fruitsModel: state.fruitsModel,
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
        } else if (state is ConnectionFailure) {
          return ConnectionLostScreen();
        } else {
          return Container();
        }
      },
    );
  }
}
