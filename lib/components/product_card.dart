import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/details_screen/details_screen.dart';

import '../constants.dart';
import '../cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import '../util/size_config.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    this.width = 160,
    this.aspectRetio = 1.02,
    required this.product,
    required this.id,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product? product;
  final int id;

  NetworkImage getImage(String imageurl) {
    String url = imageLoadUrl + imageurl;
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () async => {
            // await Navigator.pushNamed(
            //   context,
            //   DetailsScreen.routeName,
            //   arguments: ProductDetailsArguments(product: product!),
            // ),
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsView(
                    product: product!,
                  ),
                )),
            context.read<YourCartScreenCubit>().getCartData()
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.00,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageLoadUrl + product!.productImage!,
                    placeholder: (context, url) => Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(Icons.image_search_outlined),
                      ),
                    ),
                    //  Shimmer.fromColors(
                    //   child: Container(
                    //       padding:
                    //           EdgeInsets.all(getProportionateScreenWidth(20)),
                    //       decoration: BoxDecoration(
                    //         color: kSecondaryColor.withOpacity(0.1),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Container()),
                    //   baseColor: Colors.grey.shade300,
                    //   highlightColor: Colors.grey.shade100,
                    // ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.image_search_outlined),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product!.productName!,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\Rs.${product!.productPrice}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(50),
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  //     height: getProportionateScreenWidth(28),
                  //     width: getProportionateScreenWidth(28),
                  //     decoration: BoxDecoration(
                  //       color:
                  //           // product.isFavourite
                  //           //     ? kPrimaryColor.withOpacity(0.15)
                  //           //     :
                  //           kSecondaryColor.withOpacity(0.1),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: SvgPicture.asset(
                  //       "assets/icons/Heart Icon_2.svg",
                  //       color:
                  //           // product.isFavourite
                  //           //     ? Color(0xFFFF4848)
                  //           //     :
                  //           Color(0xFFDBDEE4),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
