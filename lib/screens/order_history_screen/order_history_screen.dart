import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/order_history_screen/components/body.dart';

import '../../bloc/network_bloc/bloc/network_bloc.dart';
import '../../constants.dart';
import '../connection_lost.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  static String routeName = "/orderHistory_screen";

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
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Fruits',
                  style: TextStyle(color: Colors.white),
                ),
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
