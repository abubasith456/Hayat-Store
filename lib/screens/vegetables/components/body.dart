import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/vegetables_model.dart';
import 'package:shop_app/screens/details_screen/details_screen.dart';
import 'package:shop_app/screens/vegetables/components/vegetable_card.dart';
import 'package:shop_app/util/scroll_behaviour.dart';

class Body extends StatelessWidget {
  Body({required this.vegetable, Key? key}) : super(key: key);
  ProductModel vegetable;
//Vegetable Cards
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          itemCount: vegetable.count,
          itemBuilder: (ctx, i) {
            return GestureDetector(
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsView(
                      product: vegetable.product![i],
                      category: "vegetables",
                    ),
                  ),
                );
              }),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                elevation: 5,
                child: Container(
                  height: 290,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: vegetable.product![i].productImage!,
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
                            vegetable.product![i].productName!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Rs.${vegetable.product![i].productPrice!}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
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
        elevation: 5,
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
