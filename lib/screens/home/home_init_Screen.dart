import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/foundation/key.dart';

import 'components/body.dart';

class HomeScreenInit extends StatefulWidget {
  const HomeScreenInit({Key? key}) : super(key: key);

  @override
  State<HomeScreenInit> createState() => _HomeScreenInitState();
}

class _HomeScreenInitState extends State<HomeScreenInit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
