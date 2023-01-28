import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/product_model.dart';
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
          Positioned(
            top: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.6,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      onChanged: (value) => print(value),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenWidth(9)),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Search product",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(12)),
                          height: getProportionateScreenWidth(39),
                          width: getProportionateScreenWidth(39),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/icons/Cart Icon.svg"),
                        ),
                        Positioned(
                          top: -3,
                          right: 0,
                          child: Container(
                            height: getProportionateScreenWidth(16),
                            width: getProportionateScreenWidth(16),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF4848),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  height: 1,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(12)),
                          height: getProportionateScreenWidth(39),
                          width: getProportionateScreenWidth(39),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/icons/Bell.svg"),
                        ),
                        Positioned(
                          top: -3,
                          right: 0,
                          child: Container(
                            height: getProportionateScreenWidth(16),
                            width: getProportionateScreenWidth(16),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF4848),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  height: 1,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
      )

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Container(
      //       width: SizeConfig.screenWidth * 0.6,
      //       decoration: BoxDecoration(
      //         color: kSecondaryColor.withOpacity(0.1),
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //       child: TextField(
      //         onChanged: (value) => print(value),
      //         decoration: InputDecoration(
      //             contentPadding: EdgeInsets.symmetric(
      //                 horizontal: getProportionateScreenWidth(20),
      //                 vertical: getProportionateScreenWidth(9)),
      //             border: InputBorder.none,
      //             focusedBorder: InputBorder.none,
      //             enabledBorder: InputBorder.none,
      //             hintText: "Search product",
      //             prefixIcon: Icon(Icons.search)),
      //       ),
      //     ),
      //     SizedBox(
      //       width: 20,
      //     ),
      //     InkWell(
      //       borderRadius: BorderRadius.circular(100),
      //       onTap: () {},
      //       child: Stack(
      //         clipBehavior: Clip.none,
      //         children: [
      //           Container(
      //             padding: EdgeInsets.all(getProportionateScreenWidth(12)),
      //             height: getProportionateScreenWidth(39),
      //             width: getProportionateScreenWidth(39),
      //             decoration: BoxDecoration(
      //               color: kSecondaryColor.withOpacity(0.1),
      //               shape: BoxShape.circle,
      //             ),
      //             child: SvgPicture.asset(""),
      //           ),
      //           Positioned(
      //             top: -3,
      //             right: 0,
      //             child: Container(
      //               height: getProportionateScreenWidth(16),
      //               width: getProportionateScreenWidth(16),
      //               decoration: BoxDecoration(
      //                 color: Color(0xFFFF4848),
      //                 shape: BoxShape.circle,
      //                 border: Border.all(width: 1.5, color: Colors.white),
      //               ),
      //               child: Center(
      //                 child: Text(
      //                   "",
      //                   style: TextStyle(
      //                     fontSize: getProportionateScreenWidth(10),
      //                     height: 1,
      //                     fontWeight: FontWeight.w600,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     InkWell(
      //       borderRadius: BorderRadius.circular(100),
      //       onTap: () {},
      //       child: Stack(
      //         clipBehavior: Clip.none,
      //         children: [
      //           Container(
      //             padding: EdgeInsets.all(getProportionateScreenWidth(12)),
      //             height: getProportionateScreenWidth(39),
      //             width: getProportionateScreenWidth(39),
      //             decoration: BoxDecoration(
      //               color: kSecondaryColor.withOpacity(0.1),
      //               shape: BoxShape.circle,
      //             ),
      //             child: SvgPicture.asset(""),
      //           ),
      //           Positioned(
      //             top: -3,
      //             right: 0,
      //             child: Container(
      //               height: getProportionateScreenWidth(16),
      //               width: getProportionateScreenWidth(16),
      //               decoration: BoxDecoration(
      //                 color: Color(0xFFFF4848),
      //                 shape: BoxShape.circle,
      //                 border: Border.all(width: 1.5, color: Colors.white),
      //               ),
      //               child: Center(
      //                 child: Text(
      //                   "",
      //                   style: TextStyle(
      //                     fontSize: getProportionateScreenWidth(10),
      //                     height: 1,
      //                     fontWeight: FontWeight.w600,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      );
}
