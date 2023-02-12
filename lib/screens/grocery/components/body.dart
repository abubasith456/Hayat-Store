import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/grocery_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/details_screen/details_screen.dart';

class Body extends StatelessWidget {
  Body({required this.groceryItems, Key? key}) : super(key: key);
  ProductModel groceryItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: groceryItems.count,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsView(
                            product: groceryItems.product![i],
                            category: "grocery",
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
                          imageUrl: imageLoadUrl +
                              groceryItems.product![i].productImage!,
                          placeholder: (context, url) => Center(
                            child: Container(
                              alignment: Alignment.center,
                              child: Icon(Icons.image_search_outlined),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image_search_outlined),
                        ),
                      ),
                      AutoSizeText(
                        groceryItems.product![i].productName!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Rs.${groceryItems.product![i].productPrice!}',
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
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      ),
    );

    // Padding(
    //     padding: EdgeInsets.all(10),
    //     child: Container(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).size.height,
    //       child: GridView.count(
    //         addAutomaticKeepAlives: true,
    //         crossAxisCount:
    //             MediaQuery.of(context).orientation == Orientation.landscape
    //                 ? 4
    //                 : 2,
    //         children: List.generate(vegetable.count!, (index) {
    //           return Padding(
    //             padding: const EdgeInsets.all(3),
    //             child: VegetableCard(
    //               vegetable: vegetable.products![index],
    //             ),
    //           );
    //         }),
    //       ),
    //     )

    //     //  ListView.builder(
    //     //     itemCount: vegetable.count,
    //     //     itemBuilder: ((context, index) {
    //     //       return Padding(
    //     //         padding: const EdgeInsets.all(8.0),
    //     //         child: VegetableCard(
    //     //           vegetable: vegetable.products![index],
    //     //         ),
    //     //       );
    //     //     })),
    //     );
  }
}
