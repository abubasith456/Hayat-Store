import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';

import '../../bloc/login_bloc/bloc/login_bloc.dart';
import 'components/body.dart';

class HomeScreenInit extends StatefulWidget {
  const HomeScreenInit({Key? key}) : super(key: key);

  @override
  State<HomeScreenInit> createState() => _HomeScreenInitState();
}

HomeBloc _homeBloc = HomeBloc();

class _HomeScreenInitState extends State<HomeScreenInit> {
  @override
  void initState() {
    _homeBloc.add(GetProductListEvent());
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close().then((value) => print('Home state closed'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
