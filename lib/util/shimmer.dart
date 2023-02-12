import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_app/util/size_config.dart';

import '../constants.dart';
import '../screens/home/components/categories.dart';
import '../screens/home/components/section_title.dart';
import '../screens/home/components/special_offers.dart';

Widget customShimmer(BuildContext context, Widget child) {
  return Shimmer.fromColors(
    child: child,
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
  );
}

Widget shimmerListWidget(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          addAutomaticKeepAlives: true,
          crossAxisCount: 2,
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
                    ],
                  )),
            );
          }),
        ),
      ));
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

Widget homeScreenShimmer(BuildContext context) {
  SizeConfig().init(context);
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ListTile(
                  title: Text(
                    "HAYAT",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Smart shoping',
                    style: TextStyle(
                      color: Color(0xffd4d4d4),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Cart Icon.svg",
                        press: () {},
                        numOfitem: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Bell.svg",
                        numOfitem: 3,
                        press: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HomeHeader(),
                  // SizedBox(height: getProportionateScreenHeight(5)),
                  // SizedBox(height: getProportionateScreenHeight(20)),
                  // SizedBox(height: getProportionateScreenWidth(10)),
                  Container(
                    // height: 90,
                    width: double.infinity,
                    margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(15),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF4A3298),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "A Summer Surpise\n"),
                          TextSpan(
                            text: "Cashback 20%",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(24),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            categories.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CategoryCard(
                                icon: categories[index]['icon'],
                                text: categories[index]['text'],
                                // categoryModel: categoryModel![index],
                                press: () {},
                              ),
                            ),
                          ),
                        ),
                      )),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
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
                  ),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  //
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child:
                            SectionTitle(title: "New Products", press: () {}),
                      ),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              3,
                              (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(20)),
                                  child: SizedBox(
                                    width: getProportionateScreenWidth(160),
                                    child: GestureDetector(
                                      onTap: () async => {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.00,
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  getProportionateScreenWidth(
                                                      20)),
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: imageLoadUrl + "",
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Icon(Icons
                                                        .image_search_outlined),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons
                                                        .image_search_outlined),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Name",
                                            style:
                                                TextStyle(color: Colors.black),
                                            maxLines: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rs.0",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          18),
                                                  fontWeight: FontWeight.w600,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: getProportionateScreenWidth(20)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              ),
            ),
          ),
        ],
      ));
}
