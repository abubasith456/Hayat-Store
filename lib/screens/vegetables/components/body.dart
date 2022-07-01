import 'package:flutter/material.dart';
import 'package:shop_app/models/vegetables_model.dart';
import 'package:shop_app/screens/vegetables/components/vegetable_card.dart';

class Body extends StatelessWidget {
  Body({required this.vegetable, Key? key}) : super(key: key);
  VegetablesModel vegetable;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          addAutomaticKeepAlives: true,
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 4
                  : 2,
          children: List.generate(vegetable.count!, (index) {
            return Padding(
              padding: const EdgeInsets.all(3),
              child: VegetableCard(
                vegetable: vegetable.products![index],
              ),
            );
          }),
        )

        //  ListView.builder(
        //     itemCount: vegetable.count,
        //     itemBuilder: ((context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: VegetableCard(
        //           vegetable: vegetable.products![index],
        //         ),
        //       );
        //     })),
        );
  }
}
