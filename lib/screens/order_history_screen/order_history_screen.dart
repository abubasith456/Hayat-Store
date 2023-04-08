import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shop_app/bloc/oder_history_bloc/bloc/order_history_bloc.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/screens/order_history_screen/components/body.dart';
import 'package:shop_app/screens/order_history_screen/components/items_card.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';
import 'package:shop_app/util/adaptive_dialog.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:shop_app/util/shimmer.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../api/api_provider.dart';
import '../../bloc/network_bloc/bloc/network_bloc.dart';
import '../../constants.dart';
import '../../services/locator.dart';
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
    CustomDialog customDialog = CustomDialog(context: context);
    return WillPopScope(
        onWillPop: () async => true,
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
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: const Text(
                      'Order History',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: BlocConsumer<OrderHistoryBloc, OrderHistoryState>(
                      listener: (context, state) {
                    if (state is OrderCanceling) {
                      customDialog.showProgressDialog(
                          cancelingOrderProgressText, "", false,
                          alertType: StylishDialogType.PROGRESS);
                    } else if (state is OrderDeleting) {
                      customDialog.showProgressDialog(deletingOrder, "", false,
                          alertType: StylishDialogType.PROGRESS);
                    }

                    if (state is OrderCancelFailure) {
                      print("OrderCancelFailure called =====> ");
                      customDialog.dismissDialog();
                      BlocProvider.of<OrderHistoryBloc>(context)
                          .add(FetchHistoryList());
                      showAdaptiveAlertDialog(
                          context, exceptinTitle, exceptinMessage, () {
                        Navigator.of(context).pop();
                      }, buttonOkText);
                    }

                    if (state is OrderCancelSuccess) {
                      customDialog.dismissDialog();
                      BlocProvider.of<OrderHistoryBloc>(context)
                          .add(FetchHistoryList());
                    }

                    if (state is OrderDeleteSuccess) {
                      customDialog.dismissDialog();
                      BlocProvider.of<OrderHistoryBloc>(context)
                          .add(FetchHistoryList());
                    }

                    if (state is OrderDeleteFailure) {
                      print("OrderDeleteFailure called =====> ");
                      customDialog.dismissDialog();
                      BlocProvider.of<OrderHistoryBloc>(context)
                          .add(FetchHistoryList());
                      showAdaptiveAlertDialog(
                          context, exceptinTitle, exceptinMessage, () {
                        Navigator.of(context).pop();
                        BlocProvider.of<OrderHistoryBloc>(context)
                            .add(FetchHistoryList());
                      }, buttonOkText);
                    }
                  }, builder: (context, state) {
                    if (state is FetchOrderHistorySuccess) {
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
                  }));
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
    await Future.delayed(Duration(seconds: 1));
    String userId = sl<SharedPrefService>().getData(userIdKey).toString();
    var api = new ApiProvider();
    var response = await api.getOrders(userId);
    List<OrderHistoryModel> responselist =
        response.map((e) => OrderHistoryModel.fromJson(e)).toList();
    yield responselist;
  }
}
