import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../util/size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Special for you",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image:
                    "https://d1jie5o4kjowzg.cloudfront.net/deli-headline-banner-images/schnucks_eatwell_052220_deli-v2.png",
                category: "New Banner",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image:
                    "https://www.jiomart.com/images/cms/aw_rbslider/slides/1656675848_Main-banner--756x-325.jpg",
                category: "Package",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: image,
                  placeholder: (context, url) => cacheShimmer(context),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image_search_outlined),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // begin: Align/
                    colors: [
                      Color(0xFF343434).withOpacity(0.4),
                      Color(0xFF343434).withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: getProportionateScreenWidth(15.0),
              //     vertical: getProportionateScreenWidth(10),
              //   ),
              //   child: Text.rich(
              //     TextSpan(
              //       style: TextStyle(color: Colors.white),
              //       children: [
              //         TextSpan(
              //           text: "$category\n",
              //           style: TextStyle(
              //             fontSize: getProportionateScreenWidth(18),
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         TextSpan(text: "$numOfBrands Left")
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  cacheShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
          width: getProportionateScreenWidth(335),
          height: getProportionateScreenHeight(140),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
