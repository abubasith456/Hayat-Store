import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/drinks_model.dart';
import 'package:shop_app/models/grocery_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/details_screen/details_screen.dart';

class Body extends StatelessWidget {
  Body({required this.drinksItems, Key? key}) : super(key: key);
  ProductModel drinksItems;

  NetworkImage getImage(String imageName) {
    String url = imageLoadUrl + imageName;
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: drinksItems.count,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsView(
                            product: drinksItems.product![i],
                            category: "drinks",
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
                          imageUrl: drinksItems.product![i].productImage!,
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
                      Text(
                        drinksItems.product![i].productName!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Rs.${drinksItems.product![i].productPrice!}',
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

  Widget cacheShimmer(BuildContext context) {
    return Shimmer.fromColors(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        child: Container(
          height: 290,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(8),
          child: Container(),
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}
