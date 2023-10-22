import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/orderHistoryModel.dart';

import '../../../util/size_config.dart';

class ItemsCard extends StatelessWidget {
  const ItemsCard({
    required this.products,
    Key? key,
  }) : super(key: key);

  final Products products;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        SizedBox(
          width: 95,
          child: AspectRatio(
            aspectRatio: 0.95,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                imageUrl: products.productImage!,
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
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              products.productName!,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      //Number of item
                      text: " x${products.quantity}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );

    //  Row(
    //   children: [
    //     SizedBox(
    //       width: 95,
    //       child: AspectRatio(
    //         aspectRatio: 0.95,
    //         child: Container(
    //             padding: EdgeInsets.all(getProportionateScreenWidth(10)),
    //             decoration: BoxDecoration(
    //               color: Color(0xFFF5F6F9),
    //               borderRadius: BorderRadius.circular(15),
    //             ),
    //             child: Text("3")
    //             //  CachedNetworkImage(
    //             //   imageUrl: "https://cdn.xxl.thumbs.canstockphoto.com/order-word-stamp-in-vector-format-clipart-vector_csp6017175.jpg",
    //             //   placeholder: (context, url) => Center(
    //             //     child: Container(
    //             //       alignment: Alignment.center,
    //             //       child: Icon(Icons.image_search_outlined),
    //             //     ),
    //             //   ),
    //             //   errorWidget: (context, url, error) =>
    //             //       Icon(Icons.image_search_outlined),
    //             // ),
    //             ),
    //       ),
    //     ),
    //     SizedBox(width: 20),
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           "Order",
    //           style: TextStyle(color: Colors.black, fontSize: 16),
    //           maxLines: 2,
    //         ),
    //         SizedBox(height: 10),
    //         Text.rich(
    //           TextSpan(
    //             text: "12345",
    //             style: TextStyle(
    //                 fontWeight: FontWeight.w600, color: kPrimaryColor),
    //             children: [
    //               TextSpan(
    //                   //Number of item
    //                   text: "Noting",
    //                   style: Theme.of(context).textTheme.bodyText1),
    //             ],
    //           ),
    //         )
    //       ],
    //     )
    //   ],
    // );
  }
}
