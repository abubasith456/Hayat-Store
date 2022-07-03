import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/screens/home/components/section_title.dart';

import '../../../components/product_card.dart';
import '../../../util/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LoadingHomeState) {
            Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (state is HomeErrorState) {
            if (state.productError != "") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.productError),
                ),
              );
            } else if (state is LoadedHomeState) {
              BlocProvider.of<HomeBloc>(context).add(LoadImageEvent());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.categoryError),
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
            return shimmerWidget(context);
          } else if (state is LoadedHomeState) {
            return Stack(
              children: [
                Positioned(
                  top: 10,
                  child: HomeHeader(),
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
                        DiscountBanner(),
                        Categories(),
                        SpecialOffers(),
                        SizedBox(height: getProportionateScreenWidth(30)),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: SectionTitle(
                                  title: "Our Products", press: () {}),
                            ),
                            SizedBox(height: getProportionateScreenWidth(20)),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    state.productModel.count!,
                                    (index) {
                                      return ProductCard(
                                          product: state
                                              .productModel.products![index]);

                                      // return SizedBox
                                      //     .shrink(); // here by default width and height is 0
                                    },
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(20)),
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
            );
          } else {
            return shimmerWidget(context);
          }
        },
      ),
    );
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
