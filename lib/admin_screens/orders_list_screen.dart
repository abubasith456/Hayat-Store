import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shop_app/bloc/oder_history_bloc/bloc/order_history_bloc.dart';
import 'package:shop_app/bloc/orders_admin_bloc/bloc/orders_admin_bloc.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/admin_screens/components/body.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/firebase_push/firebase_push.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';
import 'package:shop_app/util/adaptive_dialog.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:shop_app/util/shimmer.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../api/api_provider.dart';
import '../../bloc/network_bloc/bloc/network_bloc.dart';
import '../../constants.dart';
import '../../services/locator.dart';
import '../screens/connection_lost.dart';

class OrdersListAdminScreen extends StatefulWidget {
  const OrdersListAdminScreen({Key? key}) : super(key: key);

  static String routeName = "/orderListAdmin";

  @override
  State<OrdersListAdminScreen> createState() => _OrdersListAdminScreenState();
}

class _OrdersListAdminScreenState extends State<OrdersListAdminScreen> {
  @override
  void initState() {
    super.initState();
    storeLocallyPushToken();
    //Set the push token after login
    sePushtoken(context);
  }

  @override
  Widget build(BuildContext context) {
    CustomDialog customDialog = CustomDialog(context: context);
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocProvider(
          create: (context) => OrdersAdminBloc()..add(FetchOrdersList()),
          child:
              BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
            if (state is ConnectionSuccess) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: Container(),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Orders List',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: BlocConsumer<OrdersAdminBloc, OrdersAdminState>(
                      listener: (context, state) {
                    if (state is AcceptingOrder) {
                      customDialog.showProgressDialog(acceptingOrder, "", false,
                          alertType: StylishDialogType.PROGRESS);
                    } else if (state is PreparingOrder) {
                      customDialog.showProgressDialog(perparingOrder, "", false,
                          alertType: StylishDialogType.PROGRESS);
                    } else if (state is CancellingOrder) {
                      customDialog.showProgressDialog(perparingOrder, "", false,
                          alertType: StylishDialogType.PROGRESS);
                    }

                    if (state is AcceptingSuccess ||
                        state is CancellingSuccess ||
                        state is PreparingSuccess) {
                      customDialog.dismissDialog();
                      BlocProvider.of<OrdersAdminBloc>(context)
                          .add(FetchOrdersList());
                    }

                    if (state is AcceptingError ||
                        state is CancellingError ||
                        state is PreparingError) {
                      showAdaptiveAlertDialog(
                          context, exceptinTitle, exceptinMessage, () {
                        Navigator.of(context).pop();
                        // Will add cancel order api
                      }, buttonOkText);
                    }
                  }, builder: (context, state) {
                    if (state is FetchOrderForAdminSuccess) {
                      return StreamBuilder(
                        stream: productsStream(),
                        builder: (context,
                            AsyncSnapshot<List<OrderHistoryModel>> snapshot) {
                          if (snapshot.hasData) {
                            return Body(orderHistory: snapshot.data);
                          } else {
                            return Center(
                              child: customShimmer(
                                  context, _shimmeringWidget(context)),
                            );
                          }
                        },
                      );
                    } else if (state is FetchOrderHistoryFailure) {
                      return const Center(
                        child: Text("No data found"),
                      );
                    } else {
                      return customShimmer(context, _shimmeringWidget(context));
                    }
                  }),
                  floatingActionButton: SpeedDial(
                    animatedIcon: AnimatedIcons.menu_arrow,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.4,
                    spacing: 10,
                    closeManually: false,
                    children: [
                      SpeedDialChild(
                          child: const Icon(Icons.logout),
                          label: "Logout",
                          onTap: () async {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                            await UserDb.instance.delete(1);
                            await MyDatabase.instance.deleteTable();
                            sl<SharedPrefService>().clearData();
                          })
                    ],
                  )
                  // FloatingActionButton(
                  //     splashColor: Colors.purple,
                  //     hoverColor: Colors.orange,
                  //     onPressed: () {}),
                  );
            } else if (state is ConnectionFailure) {
              return ConnectionLostScreen();
            } else {
              return Container();
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

Stream<List<OrderHistoryModel>> productsStream() async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    String userId = sl<SharedPrefService>().getData(userIdKey).toString();
    var api = ApiProvider();
    var response = await api.getAllOrders();
    List<OrderHistoryModel> responselist =
        response.map((e) => OrderHistoryModel.fromJson(e)).toList();
    yield responselist;
  }
}
