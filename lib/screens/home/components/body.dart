import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/firebase/cubit/firebase_cubit.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/services/Location/location.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/permission/permission.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';
import 'package:shop_app/util/scroll_behaviour.dart';
import 'package:shop_app/util/shimmer.dart';

import '../../../components/product_card.dart';
import '../../../util/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? area = null;

  String? pinCode = null;

  @override
  void initState() {
    super.initState();
  }
  // var _provider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LoadingHomeState) {
          Center(child: CircularProgressIndicator(color: Colors.black));
        }

        if (state is StreetAdressState) {
          area = state.area;
          pinCode = state.pinCode;
        }

        if (state is LoadedHomeState) {
          area = sl<SharedPrefService>().getData(areaNameKey).toString();
          pinCode = sl<SharedPrefService>().getData(pinCodeKey).toString();
          print("LoadedHomeState ===> $area , and $pinCode");
        }

        if (state is HomeErrorState) {
          if (state.productError != "") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.productError),
              ),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.productError),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return homeScreenShimmer(context);
        } else if (state is LoadedHomeState) {
          return Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(70),
            //   child: AppBar(
            //       excludeHeaderSemantics: false,
            //       elevation: 0,
            //       automaticallyImplyLeading: false,
            //       title: Padding(
            //         padding: const EdgeInsets.only(top: 15),
            //         child: Text(
            //           "HAYAT",
            //           style: TextStyle(
            //               fontSize: 30,
            //               fontWeight: FontWeight.w900,
            //               color: Colors.black),
            //         ),
            //       ),
            //       actions: [
            //         Padding(
            //           padding: const EdgeInsets.only(top: 10, left: 10),
            //           child:
            //               BlocBuilder<YourCartScreenCubit, YourCartItemCount>(
            //             builder: (context, state) {
            //               return IconBtnWithCounter(
            //                 svgSrc: "assets/icons/Cart Icon.svg",
            //                 press: () {
            //                   Navigator.pushNamed(
            //                       context, CartScreen.routeName);
            //                   // context.read<HomeBloc>().close();
            //                 },
            //                 numOfitem: state.item,
            //               );
            //             },
            //           ),
            //         ),
            //       ]),
            // ),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: ListTile(
                          title: const Text(
                            "HAYAT",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            _validateAddress(area, pinCode)
                                ? '$area,$pinCode'
                                : 'Smart Shoping',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlocBuilder<YourCartScreenCubit,
                                  YourCartItemCount>(
                                builder: (context, state) {
                                  return IconBtnWithCounter(
                                    svgSrc: "assets/icons/Cart Icon.svg",
                                    press: () {
                                      Navigator.pushNamed(
                                          context, CartScreen.routeName);
                                      // context.read<HomeBloc>().close();
                                    },
                                    numOfitem: state.item,
                                  );
                                },
                              ),
                              const SizedBox(
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
                  // Positioned(
                  //   top: 10,
                  //   child: HomeHeader(),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: ScrollConfiguration(
                      behavior: MyBehaviour(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DiscountBanner(),
                            Categories(),
                            SpecialOffers(),
                            SizedBox(height: getProportionateScreenWidth(30)),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20)),
                                  child: SectionTitle(
                                      title: "New Products", press: () {}),
                                ),
                                SizedBox(
                                    height: getProportionateScreenWidth(20)),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...List.generate(
                                        state.productModel.count!,
                                        (index) {
                                          return ProductCard(
                                            product: state
                                                .productModel.product![index],
                                            id: index,
                                          );

                                          // return SizedBox
                                          //     .shrink(); // here by default width and height is 0
                                        },
                                      ),
                                      SizedBox(
                                          width:
                                              getProportionateScreenWidth(20)),
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
                  ),
                ],
              ),
            ),
          );
        } else {
          return SafeArea(child: homeScreenShimmer(context));
        }
      },
    );
  }

  bool _validateAddress(String? area, String? pinCode) {
    if (area != null &&
        pinCode != null &&
        area != "null" &&
        pinCode != "null") {
      if (area.isNotEmpty && pinCode.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  Widget shimmerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const SizedBox(height: 80),
              );
            },
          ),
        ),
      ),
    );
    // SizedBox(
    //   width: 200.0,
    //   height: 100.0,
    //   child: Shimmer.fromColors(
    //     baseColor: Colors.red,
    //     highlightColor: Colors.yellow,
    //     child: Text(
    //       'Shimmer',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 40.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // ),
    // SizedBox(
    //   width: 200.0,
    //   height: 100.0,
    //   child: Shimmer.fromColors(
    //     baseColor: Colors.red,
    //     highlightColor: Colors.yellow,
    //     child: Text(
    //       'Shimmer',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 40.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // ),
  }
}
