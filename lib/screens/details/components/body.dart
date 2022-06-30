import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/my_db_model.dart';
import 'package:shop_app/util/size_config.dart';
import '../../../constants.dart';
import '../../../models/product_model.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Products product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //   bottom: 0,
        //   width: MediaQuery.of(context).size.width,
        //   child: Center(
        //     child: TopRoundedContainer(
        //       color: Colors.white,
        //       child: Padding(
        //           padding: EdgeInsets.only(
        //             left: SizeConfig.screenWidth * 0.15,
        //             right: SizeConfig.screenWidth * 0.15,
        //             bottom: getProportionateScreenWidth(40),
        //             top: getProportionateScreenWidth(15),
        //           ),
        //           child:

        //           // DefaultButton(
        //           //   text: "Add To Cart",
        //           //   isLoading: false,
        //           //   press: () {
        //           //     final cart = Cart(
        //           //         name: product.name!,
        //           //         price: product.price!.toString(),
        //           //         description: product.description!,
        //           //         categoryId: product.category!,
        //           //         productImage: product.productImage!,
        //           //         productId: product.sId!);

        //           //     MyDatabase.instance.create(cart);

        //           //     print("Button pressed");
        //           //   },
        //           // ),

        //           ),
        //     ),
        //   ),
        // ),
        ListView(
          children: [
            ProductImages(product: product),
            TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  ProductDescription(
                    product: product,
                    pressOnSeeMore: () {},
                  ),
                  TopRoundedContainer(
                    color: Color(0xFFF6F7F9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // ColorDots(product: product!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(56),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () async {
                  final cart = Cart(
                      name: product.name!,
                      price: product.price!.toString(),
                      description: product.description!,
                      categoryId: product.category!,
                      productImage: product.productImage!,
                      productId: product.sId!);

                  await MyDatabase.instance.create(cart);
                },
                child:
                    // false
                    //     ? CircularProgressIndicator(
                    //         color: Colors.white,
                    //       )
                    //     :
                    Text(
                  "Add To Cart DB",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
