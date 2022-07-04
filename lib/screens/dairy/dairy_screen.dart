import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/dairy_bloc/bloc/dairy_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/dairy/components/body.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'package:shop_app/util/shimmer.dart';

import '../../constants.dart';

class DairyScreen extends StatefulWidget {
  const DairyScreen({Key? key}) : super(key: key);

  @override
  State<DairyScreen> createState() => _DairyScreenState();
}

class _DairyScreenState extends State<DairyScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
            create: (context) => DairyBloc()..add(GetDairyListEvent()),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Dairy',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: BlocConsumer<DairyBloc, DairyState>(
                listener: (context, state) {
                  if (state is DairyErrorState) {
                    showSnackBar(
                        context: context,
                        text: "Something went wrong!...Please try again later",
                        type: TopSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is DairyLoadingState) {
                    return shimmerListWidget(context);
                  } else if (state is DairyLoadedState) {
                    return SafeArea(
                      child: Body(
                        dairyProduct: state.dairyModel,
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
