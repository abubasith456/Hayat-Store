import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/my_address_bloc/bloc/my_address_bloc.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  var mobilenumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: BlocConsumer<MyAddressBloc, MyAddressState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchedMyAddressData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.myAddressList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //
                    },
                    child: SizedBox(
                      height: 500,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        elevation: 5,
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
                child: SizedBox(
              child: Text("No data found"),
            ));
          }
        },
      ),
    ));
  }
}
