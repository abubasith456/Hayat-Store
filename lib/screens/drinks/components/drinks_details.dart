// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/drinks_model.dart';
import 'package:shop_app/models/grocery_model.dart';
import 'package:shop_app/models/my_db_model.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../cubit/cart_counter/cart_counter_cubit.dart';
import '../../../db/database.dart';

class DrinksDetailsView extends StatelessWidget {
  DrinksDetailsView({required this.drinksProduct, Key? key}) : super(key: key);
  static String routeName = "/cartDetails";
  final DrinksProduct drinksProduct;

  String baseurl = "https://hidden-waters-80713.herokuapp.com/";
  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater(imageName);
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCounterCubit(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Ionicons.bag_outline,
          //       color: Colors.black,
          //     ),
          //   ),
          // ],
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .35,
              padding: const EdgeInsets.only(bottom: 30),
              color: kPrimaryColor,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imageLoadUrl + drinksProduct.drinksImage!,
                placeholder: (context, url) => cacheShimmer(context),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image_search_outlined),
              ),
              // Image.asset('assets/images/ps4_console_blue_1.png'),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product:',
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${drinksProduct.name}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\Rs.${drinksProduct.price}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Text(
                            '${drinksProduct.description}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            // style: GoogleFonts.poppins(
                            //   fontSize: 15,
                            //   color: Colors.grey,
                            // ),
                          ),
                          const SizedBox(height: 15),
                          // SizedBox(
                          //   height: 110,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: ,
                          //     itemBuilder: (context, index) => Container(
                          //       margin: const EdgeInsets.only(right: 6),
                          //       width: 110,
                          //       height: 110,
                          //       decoration: BoxDecoration(
                          //         color: AppColors.kSmProductBgColor,
                          //         borderRadius: BorderRadius.circular(20),
                          //       ),
                          //       child: Center(
                          //         child: Image(
                          //           height: 70,
                          //           image: AssetImage(smProducts[index].image),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: _shoppingItem(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartCounterCubit, double>(
          builder: (context, state) {
            return Container(
              height: 70,
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.heart_broken_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final cart = Cart(
                            name: drinksProduct.name!,
                            price: drinksProduct.price!.toString(),
                            description: drinksProduct.description!,
                            productImage: drinksProduct.drinksImage!,
                            productId: drinksProduct.sId!,
                            quantity: state.toString());

                        await MyDatabase.instance.create(cart);

                        showSnackBar(
                            context, "Cart Added", TopSnackBarType.success);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          // style: GoogleFonts.poppins(
                          //   fontSize: 15,
                          //   fontWeight: FontWeight.w500,
                          //   color: Colors.white,
                          // ),
                        ),

                        //  Obx(
                        //   () =>
                        //       ? SizedBox(
                        //           width: 20,
                        //           height: 20,
                        //           child: CircularProgressIndicator(
                        //             color: Colors.white,
                        //             strokeWidth: 3,
                        //           ),
                        //         )
                        //       : Text(
                        //           '+ Add to Cart',
                        //           // style: GoogleFonts.poppins(
                        //           //   fontSize: 15,
                        //           //   fontWeight: FontWeight.w500,
                        //           //   color: Colors.white,
                        //           // ),
                        //         ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _shoppingItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: BlocBuilder<CartCounterCubit, double>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _decrementButton(context),
              SizedBox(
                width: 5,
              ),
              Text(
                '${state}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 5,
              ),
              _incrementButton(context),
              SizedBox(
                width: 2,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _incrementButton(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black87),
        backgroundColor: Colors.white,
        onPressed: () {
          context.read<CartCounterCubit>().increment();
        },
      ),
    );
  }

  Widget _decrementButton(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: FloatingActionButton(
          onPressed: () {
            context.read<CartCounterCubit>().decrement();
          },
          child: Icon(Icons.remove, color: Colors.black),
          backgroundColor: Colors.white),
    );
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
