import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/oder_history_bloc/bloc/order_history_bloc.dart';
import 'package:shop_app/screens/order_history_screen/components/body.dart';
import 'package:shop_app/screens/order_history_screen/components/items_card.dart';
import 'package:shop_app/util/shimmer.dart';

import '../../bloc/network_bloc/bloc/network_bloc.dart';
import '../../constants.dart';
import '../connection_lost.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  static String routeName = "/orderHistory_screen";

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocProvider(
          create: (context) => OrderHistoryBloc()..add(FetchHistoryList()),
          child:
              BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
            if (state is ConnectionSuccess) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'Order History',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: BlocConsumer<OrderHistoryBloc, OrderHistoryState>(
                      listener: (context, state) {
                    // TODO: implement listener
                  }, builder: (context, state) {
                    if (state is FetchOrderHistorySuccess) {
                      return Body(orderHistory: state.response);
                    } else {
                      return customShimmer(context, _shimmeringWidget(context));
                    }
                  }));
            } else {
              return ConnectionLostScreen();
            }
          }),
        ));
  }
}

_shimmeringWidget(BuildContext context) {
  return SafeArea(
    child: Container(
      child: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 5,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              animateTrailing: true,
              elevation: 30,
              leading: CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text("",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                radius: 30,
              ),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Rs. ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Status: ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "",
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
              baseColor: Color.fromARGB(179, 242, 242, 242),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          );
        }),
      ),
    ),
  );
}
