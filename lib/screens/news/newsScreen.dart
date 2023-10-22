import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/bloc/news_block/post_bloc.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/connection_lost.dart';
import 'package:shop_app/screens/news/body.dart';
import 'package:shop_app/util/enums.dart';

class NewsScreen extends StatefulWidget {
  static String routeName = "/news";

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    print("initState called bro");
    BlocProvider.of<PostBloc>(context).add(GetPost());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child:
            BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
          if (state is ConnectionSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Post",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                leading: Container(),
              ),
              body: Body(),
              // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
            );
          } else if (state is ConnectionFailure) {
            print("Bro called");
            return ConnectionLostScreen();
          } else {
            print("Bro else part called called");
            return Container();
          }
        }));
  }
}
