import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/vegetable_bloc/bloc/vegetable_screen_bloc.dart';
import 'package:shop_app/screens/vegetables/components/body.dart';

import '../../constants.dart';

class VegetableScreen extends StatefulWidget {
  const VegetableScreen({Key? key}) : super(key: key);

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
    return BlocProvider(
        create: (context) => VegetableScreenBloc()..add(GetVegetablesEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Vegetables'),
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
                return shimmerWidget(context);
              } else if (state is VegetableScreenLoadedState) {
                return Body(
                  vegetable: state.vegetablesModel,
                );
              } else {
                return shimmerWidget(context);
              }
            },
          ),
        ));
  }

  Widget shimmerWidget(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            addAutomaticKeepAlives: true,
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 4
                    : 2,
            children: List.generate(10, (index) {
              return Padding(
                padding: const EdgeInsets.all(3),
                child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          textColor: Colors.black,
                          title: Text("Loading"),
                          subtitle: Text("Rs.0"),
                          trailing: Icon(Icons.favorite_outline),
                        ),
                        SizedBox(height: 130, width: 130, child: SizedBox())
                      ],
                    )),
              );
            }),
          ),
        ));
  }
}
