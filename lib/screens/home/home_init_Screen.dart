import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shop_app/services/firestore_and_remoteConfig/firestore_database.dart';
import 'package:shop_app/services/update_service/update_service.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../bloc/login_bloc/bloc/login_bloc.dart';
import '../../constants.dart';
import '../../util/intent.dart';
import 'components/body.dart';

class HomeScreenInit extends StatefulWidget {
  const HomeScreenInit({Key? key}) : super(key: key);

  @override
  State<HomeScreenInit> createState() => _HomeScreenInitState();
}

class _HomeScreenInitState extends State<HomeScreenInit> {
  @override
  void initState() {
    super.initState();
    listernUpdateAvailable(context);
  }

  

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
