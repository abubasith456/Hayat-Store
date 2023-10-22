import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/fruit_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/details_screen/details_screen.dart';
import 'package:shop_app/screens/fruits/components/fruit_details.dart';

class Body extends StatelessWidget {
  Body({required this.fruitsModel, Key? key}) : super(key: key);
  ProductModel fruitsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: fruitsModel.count,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsView(
                            product: fruitsModel.product![i],
                            category: "fruits",
                          )));
            }),
            child: Container(
              height: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                elevation: 5,
                child: Container(
                  height: 400,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: fruitsModel.product![i].productImage!,
                          placeholder: (context, url) => Center(
                            child: Container(
                              alignment: Alignment.center,
                              child: Icon(Icons.image_search_outlined),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image_search_outlined),
                        ),

                        //      Image(
                        //   image:
                        //       getImage(vegetable.products![i].vegetableImage!),
                        // )
                      ),
                      Text(
                        fruitsModel.product![i].productName!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Rs.${fruitsModel.product![i].productPrice!}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 10,
          mainAxisExtent: 250,
        ),
      ),
    );
  }
}
