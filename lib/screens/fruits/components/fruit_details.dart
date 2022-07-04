import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cart_counter/cart_counter_cubit.dart';
import 'package:shop_app/cubit/like_product/cubit/like_product_cubit.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/models/fruit_model.dart';
import 'package:shop_app/models/my_db_model.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'package:shop_app/util/quantitiy.dart';

import '../../../constants.dart';

class FruitDetailsView extends StatelessWidget {
  FruitDetailsView({required this.fruitproduct, Key? key}) : super(key: key);
  Fruitproduct fruitproduct;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCounterCubit(),
        ),
        BlocProvider(
          create: (context) => LikeProductCubit(),
        ),
      ],
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
                imageUrl: imageLoadUrl + fruitproduct.fruitImage!,
                placeholder: (context, url) => Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.image_search_outlined),
                  ),
                ),
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
                                '${fruitproduct.name}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\Rs.${fruitproduct.price}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Text(
                            '${fruitproduct.description}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
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
                      child: quantitiySelector(context),
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
                    child: BlocBuilder<LikeProductCubit, bool>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            if (state) {
                              context.read<LikeProductCubit>().disLikeProduct();
                            } else
                              context.read<LikeProductCubit>().likeProduct();
                          },
                          icon: Icon(
                            state ? Icons.favorite : Icons.favorite_border,
                            size: 30,
                            color: state ? Colors.red : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final cart = Cart(
                            name: fruitproduct.name!,
                            price: fruitproduct.price!.toString(),
                            description: fruitproduct.description!,
                            productImage: fruitproduct.fruitImage!,
                            productId: fruitproduct.sId!,
                            quantity: state.toString());

                        await MyDatabase.instance.create(cart);

                        showSnackBar(
                            context: context,
                            text: "Cart Added",
                            type: TopSnackBarType.success);
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
}
