import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/screens/connection_lost.dart';

import '../../bloc/login_bloc/bloc/login_bloc.dart';
import 'components/body.dart';

class HomeScreenInit extends StatefulWidget {
  const HomeScreenInit({Key? key}) : super(key: key);

  @override
  State<HomeScreenInit> createState() => _HomeScreenInitState();
}

class _HomeScreenInitState extends State<HomeScreenInit> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
            create: (context) => HomeBloc()..add(GetProductListEvent()),
            child: Scaffold(
              body: Body(),
            ),
          );
        } else {
          return ConnectionLostScreen();
        }
      },
    );
  }
}
