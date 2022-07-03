import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/util/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child:
            BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
          if (state is ConnectionSuccess) {
            return Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                leading: Container(),
              ),
              body: Body(),
              // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
            );
          } else {
            return ConnectionLostScreen();
          }
        }));
  }
}
