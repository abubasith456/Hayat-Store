import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/my_address_bloc/bloc/my_address_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/my_address/components/body.dart';

class MyAddressScreen extends StatelessWidget {
  static String routeName = "/my_address";
  final _myAddressBloc = MyAddressBloc();

  MyAddressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _myAddressBloc..add(GetMyAddressData()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            GestureDetector(
              onDoubleTap: () {
                //
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Text(
                        "Add address",
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
              ),
            )
          ],
          title: const Text(title_my_address),
        ),
        body: Body(),
      ),
    );
  }
}
