import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';

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
    context.read<HomeBloc>().add(GetProductListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
