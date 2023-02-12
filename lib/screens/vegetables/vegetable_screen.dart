import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/bloc/vegetable_bloc/bloc/vegetable_screen_bloc.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_app/screens/vegetables/components/body.dart';
import 'package:shop_app/util/shimmer.dart';
import 'package:search_page/search_page.dart';

import '../../constants.dart';

class VegetableScreen extends StatefulWidget {
  static String routeName = "/vegetables";

  @override
  State<VegetableScreen> createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return BlocProvider(
              create: (context) =>
                  VegetableScreenBloc()..add(GetVegetablesEvent()),
              child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      // IconBtnWithCounter(
                      //   svgSrc: "assets/icons/Search_Icon.svg",
                      //   numOfitem: 3,
                      //   press: () {},
                      // ),
                      InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.search),
                            decoration: BoxDecoration(
                              color: kSecondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          )),
                      SizedBox(
                        width: 15,
                      )
                    ],
                    title: Text('Vegetables',
                        style: TextStyle(color: Colors.black)),
                  ),
                  body: BlocConsumer<VegetableScreenBloc, VegetableScreenState>(
                    listener: (context, state) {
                      if (state is VegetableScreenErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is VegetableScreenLoadingState) {
                        return shimmerListWidget(context);
                      } else if (state is VegetableScreenLoadedState) {
                        return Body(
                          vegetable: state.vegetablesModel,
                        );
                      } else {
                        return shimmerListWidget(context);
                      }
                    },
                  )));
        } else {
          return ConnectionLostScreen();
        }
      },
    );
  }
}
