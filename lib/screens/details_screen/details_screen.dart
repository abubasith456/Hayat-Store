import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/cart_counter/cart_counter_cubit.dart';
import 'package:shop_app/cubit/like_product/cubit/like_product_cubit.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/models/my_db_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/vegetables_model.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'dart:io' show Platform;
import '../../cubit/your_cart/cubit/your_cart_screen_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({required this.product, Key? key}) : super(key: key);
  static String routeName = "/detailsScreen";
  final Product product;

// class _ProductDetailsViewState extends State<ProductDetailsView> {
//   @override
//   void initState() {
//     context.read<YourCartScreenCubit>().getCartData();
//     super.initState();
//   }

  NetworkImage getImage(String imageUrl) {
    String url = imageLoadUrl + imageUrl;
    return NetworkImage(url);
  }

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
                Icons.arrow_back_ios_new,
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
                  imageUrl: imageLoadUrl + product.productImage!,
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
                                AutoSizeText(
                                  '${product.productName}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                AutoSizeText(
                                  '\Rs.${product.productPrice}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Text(
                              '${product.productDescription}',
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
                // Need to fix 
                height: Platform.isIOS ? 80 : 70,
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: Platform.isIOS ? 20 : 10,
                    right: Platform.isIOS ? 20 : 10,
                    bottom: Platform.isIOS ? 20 : 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (state > 0) {
                            final cart = Cart(
                                name: product.productName!,
                                price: product.productPrice!.toString(),
                                description: product.productDescription!,
                                productImage: product.productImage!,
                                productId: product.sId!,
                                quantity: state.toString());

                            await MyDatabase.instance.create(cart);

                            showSnackBar(
                                context: context,
                                text: "Cart Added",
                                type: TopSnackBarType.success);
                          } else {
                            showSnackBar(
                                context: context,
                                text:
                                    "Please select the quantity... How much you want!",
                                type: TopSnackBarType.error);
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
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
}



          // Scaffold(
          //   body: SafeArea(
          //     child: Container(
          //       child: Text("Happy please"),
          //     ),
          //   ),

          // );

//// ----Start

          // BlocBuilder<CartCounterCubit, double>(
          //   builder: (context, state) {
          //     return Container(
          //       color: Colors.white,
          //       padding: EdgeInsets.all(20),
          //       child: Container(
          //         height: 70,
          //         color: Colors.white,
          //         child: Expanded(
          //           child: InkWell(
          //             onTap: () async {
          //               if (state > 0) {
          //                 final cart = Cart(
          //                     name: product.productName!,
          //                     price: product.productPrice!.toString(),
          //                     description: product.productDescription!,
          //                     productImage: product.productImage!,
          //                     productId: product.sId!,
          //                     quantity: state.toString());

          //                 await MyDatabase.instance.create(cart);

          //                 showSnackBar(
          //                     context: context,
          //                     text: "Cart Added",
          //                     type: TopSnackBarType.success);
          //               } else {
          //                 showSnackBar(
          //                     context: context,
          //                     text:
          //                         "Please select the quantity... How much you want!",
          //                     type: TopSnackBarType.error);
          //               }
          //             },
          //             child: Container(
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(
          //                 color: kPrimaryColor,
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               child: Text(
          //                 'Add to Cart',
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold),
          //                 // style: GoogleFonts.poppins(
          //                 //   fontSize: 15,
          //                 //   fontWeight: FontWeight.w500,
          //                 //   color: Colors.white,
          //                 // ),
          //               ),

          //               //  Obx(
          //               //   () =>
          //               //       ? SizedBox(
          //               //           width: 20,
          //               //           height: 20,
          //               //           child: CircularProgressIndicator(
          //               //             color: Colors.white,
          //               //             strokeWidth: 3,
          //               //           ),
          //               //         )
          //               //       : Text(
          //               //           '+ Add to Cart',
          //               //           // style: GoogleFonts.poppins(
          //               //           //   fontSize: 15,
          //               //           //   fontWeight: FontWeight.w500,
          //               //           //   color: Colors.white,
          //               //           // ),
          //               //         ),
          //               // ),
          //             ),
          //           ),
          //         ),

          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //   children: [
          //         //     // Container(
          //         //     //   width: 50,
          //         //     //   height: 50,
          //         //     //   alignment: Alignment.center,
          //         //     //   decoration: BoxDecoration(
          //         //     //     borderRadius: BorderRadius.circular(10),
          //         //     //     border: Border.all(color: Colors.white),
          //         //     //   ),
          //         //     //   child: BlocBuilder<LikeProductCubit, bool>(
          //         //     //     builder: (context, state) {
          //         //     //       return IconButton(
          //         //     //         onPressed: () {
          //         //     //           if (state) {
          //         //     //             context.read<LikeProductCubit>().disLikeProduct();
          //         //     //           } else
          //         //     //             context.read<LikeProductCubit>().likeProduct();
          //         //     //         },
          //         //     //         icon: Icon(
          //         //     //           state ? Icons.favorite : Icons.favorite_border,
          //         //     //           size: 30,
          //         //     //           color: state ? Colors.red : Colors.grey,
          //         //     //         ),
          //         //     //       );
          //         //     //     },
          //         //     //   ),
          //         //     // ),
          //         //     SizedBox(width: 20),
          //         //     Expanded(
          //         //       child: InkWell(
          //         //         onTap: () async {
          //         //           if (state > 0) {
          //         //             final cart = Cart(
          //         //                 name: widget.product.productName!,
          //         //                 price: widget.product.productPrice!.toString(),
          //         //                 description: widget.product.productDescription!,
          //         //                 productImage: widget.product.productImage!,
          //         //                 productId: widget.product.sId!,
          //         //                 quantity: state.toString());

          //         //             await MyDatabase.instance.create(cart);

          //         //             showSnackBar(
          //         //                 context: context,
          //         //                 text: "Cart Added",
          //         //                 type: TopSnackBarType.success);
          //         //           } else {
          //         //             showSnackBar(
          //         //                 context: context,
          //         //                 text:
          //         //                     "Please select the quantity... How much you want!",
          //         //                 type: TopSnackBarType.error);
          //         //           }
          //         //         },
          //         //         child: Container(
          //         //           alignment: Alignment.center,
          //         //           decoration: BoxDecoration(
          //         //             color: kPrimaryColor,
          //         //             borderRadius: BorderRadius.circular(15),
          //         //           ),
          //         //           child: Text(
          //         //             'Add to Cart',
          //         //             style: TextStyle(
          //         //                 color: Colors.white,
          //         //                 fontSize: 15,
          //         //                 fontWeight: FontWeight.bold),
          //         //             // style: GoogleFonts.poppins(
          //         //             //   fontSize: 15,
          //         //             //   fontWeight: FontWeight.w500,
          //         //             //   color: Colors.white,
          //         //             // ),
          //         //           ),

          //         //           //  Obx(
          //         //           //   () =>
          //         //           //       ? SizedBox(
          //         //           //           width: 20,
          //         //           //           height: 20,
          //         //           //           child: CircularProgressIndicator(
          //         //           //             color: Colors.white,
          //         //           //             strokeWidth: 3,
          //         //           //           ),
          //         //           //         )
          //         //           //       : Text(
          //         //           //           '+ Add to Cart',
          //         //           //           // style: GoogleFonts.poppins(
          //         //           //           //   fontSize: 15,
          //         //           //           //   fontWeight: FontWeight.w500,
          //         //           //           //   color: Colors.white,
          //         //           //           // ),
          //         //           //         ),
          //         //           // ),
          //         //         ),
          //         //       ),
          //         //     ),

          //         //   ],
          //         // ),
          //       ),
          //     );
          //   },
          // ),

          // MultiBlocProvider(
          //   providers: [
          //     BlocProvider(
          //       create: (context) => CartCounterCubit(),
          //     ),
          //     BlocProvider(
          //       create: (context) => LikeProductCubit(),
          //     ),
          //   ],
          //   child: Scaffold(
          //     backgroundColor: kPrimaryColor,
          //     appBar: AppBar(
          //       backgroundColor: kPrimaryColor,
          //       elevation: 0,
          //       leading: IconButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         icon: const Icon(
          //           Icons.arrow_back_ios_new,
          //           color: Colors.white,
          //         ),
          //       ),
          //       // actions: [
          //       //   IconButton(
          //       //     onPressed: () {},
          //       //     icon: const Icon(
          //       //       Ionicons.bag_outline,
          //       //       color: Colors.black,
          //       //     ),
          //       //   ),
          //       // ],
          //     ),
          //     body: Container(
          //       child: Text("demeo"),
          //     ),
          // Column(
          //   children: [
          //     Container(
          //       height: MediaQuery.of(context).size.height * .35,
          //       padding: const EdgeInsets.only(bottom: 30),
          //       width: double.infinity,
          //       child: Image.asset('assets/images/main_image.png'),
          //     ),
          //     Expanded(
          //       child: Stack(
          //         children: [
          //           Container(
          //             padding:
          //                 const EdgeInsets.only(top: 40, right: 14, left: 14),
          //             decoration: const BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(30),
          //                 topRight: Radius.circular(30),
          //               ),
          //             ),
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'Chanel',
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         'Product Name',
          //                       ),
          //                       Text(
          //                         '\$135.00',
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(height: 15),
          //                   Text(
          //                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor consectetur tortor vitae interdum.',
          //                   ),
          //                   const SizedBox(height: 15),
          //                   Text(
          //                     'Similar This',
          //                   ),
          //                   const SizedBox(height: 10),
          //                   SizedBox(
          //                     height: 110,
          //                     child: ListView.builder(
          //                       scrollDirection: Axis.horizontal,
          //                       itemCount: 3,
          //                       itemBuilder: (context, index) => Container(
          //                         margin: const EdgeInsets.only(right: 6),
          //                         width: 110,
          //                         height: 110,
          //                         decoration: BoxDecoration(
          //                           color: kPrimaryColor,
          //                           borderRadius: BorderRadius.circular(20),
          //                         ),
          //                         child: Center(
          //                           child: Image(
          //                             height: 70,
          //                             image: AssetImage("assets/images/logo.png"),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   const SizedBox(height: 20),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.topCenter,
          //             child: Container(
          //               margin: const EdgeInsets.only(top: 10),
          //               width: 50,
          //               height: 5,
          //               decoration: BoxDecoration(
          //                 color: kPrimaryColor,
          //                 borderRadius: BorderRadius.circular(50),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

//------ break

          // Column(
          //   children: [
          //     Container(
          //       height: MediaQuery.of(context).size.height * .35,
          //       padding: const EdgeInsets.only(bottom: 30),
          //       color: kPrimaryColor,
          //       width: double.infinity,
          //       child: CachedNetworkImage(
          //         imageUrl: imageLoadUrl + widget.product.productImage!,
          //         placeholder: (context, url) => Center(
          //           child: Container(
          //             alignment: Alignment.center,
          //             child: Icon(Icons.image_search_outlined),
          //           ),
          //         ),
          //         errorWidget: (context, url, error) =>
          //             Icon(Icons.image_search_outlined),
          //       ),
          //       // Image.asset('assets/images/ps4_console_blue_1.png'),
          //     ),
          //     Expanded(
          //       flex: 4,
          //       child: Stack(
          //         children: [
          //           Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: MediaQuery.of(context).size.height,
          //             padding: const EdgeInsets.all(30),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(30),
          //                 topRight: Radius.circular(30),
          //               ),
          //             ),
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'Product:',
          //                     style: TextStyle(
          //                         color: Colors.black45,
          //                         fontSize: 13,
          //                         fontWeight: FontWeight.bold),
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       AutoSizeText(
          //                         '${widget.product.productName}',
          //                         style: TextStyle(
          //                             color: Colors.black,
          //                             fontSize: 18,
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                       AutoSizeText(
          //                         '\Rs.${widget.product.productPrice}',
          //                         style: TextStyle(
          //                             color: Colors.black,
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(height: 25),
          //                   Text(
          //                     '${widget.product.productDescription}',
          //                     style: TextStyle(
          //                         color: Colors.black54,
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.bold),
          //                     // style: GoogleFonts.poppins(
          //                     //   fontSize: 15,
          //                     //   color: Colors.grey,
          //                     // ),
          //                   ),
          //                   const SizedBox(height: 15),

          //                   // SizedBox(
          //                   //   height: 110,
          //                   //   child: ListView.builder(
          //                   //     scrollDirection: Axis.horizontal,
          //                   //     itemCount: ,
          //                   //     itemBuilder: (context, index) => Container(
          //                   //       margin: const EdgeInsets.only(right: 6),
          //                   //       width: 110,
          //                   //       height: 110,
          //                   //       decoration: BoxDecoration(
          //                   //         color: AppColors.kSmProductBgColor,
          //                   //         borderRadius: BorderRadius.circular(20),
          //                   //       ),
          //                   //       child: Center(
          //                   //         child: Image(
          //                   //           height: 70,
          //                   //           image: AssetImage(smProducts[index].image),
          //                   //         ),
          //                   //       ),
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   const SizedBox(height: 20),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.topCenter,
          //             child: Container(
          //               margin: const EdgeInsets.only(top: 10),
          //               width: 50,
          //               height: 5,
          //               decoration: BoxDecoration(
          //                 color: Colors.black54,
          //                 borderRadius: BorderRadius.circular(50),
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             bottom: 5,
          //             child: Container(
          //               padding: EdgeInsets.all(10),
          //               width: MediaQuery.of(context).size.width,
          //               child: _shoppingItem(context),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // bottomNavigationBar: BlocBuilder<CartCounterCubit, double>(
          //   builder: (context, state) {
          //     return Container(
          //       color: Colors.white,
          //       padding: EdgeInsets.all(20),
          //       child: Container(
          //         height: 70,
          //         color: Colors.white,
          //         child: Expanded(
          //           child: InkWell(
          //             onTap: () async {
          //               if (state > 0) {
          //                 final cart = Cart(
          //                     name: widget.product.productName!,
          //                     price: widget.product.productPrice!.toString(),
          //                     description: widget.product.productDescription!,
          //                     productImage: widget.product.productImage!,
          //                     productId: widget.product.sId!,
          //                     quantity: state.toString());

          //                 await MyDatabase.instance.create(cart);

          //                 showSnackBar(
          //                     context: context,
          //                     text: "Cart Added",
          //                     type: TopSnackBarType.success);
          //               } else {
          //                 showSnackBar(
          //                     context: context,
          //                     text:
          //                         "Please select the quantity... How much you want!",
          //                     type: TopSnackBarType.error);
          //               }
          //             },
          //             child: Container(
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(
          //                 color: kPrimaryColor,
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               child: Text(
          //                 'Add to Cart',
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold),
          //                 // style: GoogleFonts.poppins(
          //                 //   fontSize: 15,
          //                 //   fontWeight: FontWeight.w500,
          //                 //   color: Colors.white,
          //                 // ),
          //               ),

          //               //  Obx(
          //               //   () =>
          //               //       ? SizedBox(
          //               //           width: 20,
          //               //           height: 20,
          //               //           child: CircularProgressIndicator(
          //               //             color: Colors.white,
          //               //             strokeWidth: 3,
          //               //           ),
          //               //         )
          //               //       : Text(
          //               //           '+ Add to Cart',
          //               //           // style: GoogleFonts.poppins(
          //               //           //   fontSize: 15,
          //               //           //   fontWeight: FontWeight.w500,
          //               //           //   color: Colors.white,
          //               //           // ),
          //               //         ),
          //               // ),
          //             ),
          //           ),
          //         ),

          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //   children: [
          //         //     // Container(
          //         //     //   width: 50,
          //         //     //   height: 50,
          //         //     //   alignment: Alignment.center,
          //         //     //   decoration: BoxDecoration(
          //         //     //     borderRadius: BorderRadius.circular(10),
          //         //     //     border: Border.all(color: Colors.white),
          //         //     //   ),
          //         //     //   child: BlocBuilder<LikeProductCubit, bool>(
          //         //     //     builder: (context, state) {
          //         //     //       return IconButton(
          //         //     //         onPressed: () {
          //         //     //           if (state) {
          //         //     //             context.read<LikeProductCubit>().disLikeProduct();
          //         //     //           } else
          //         //     //             context.read<LikeProductCubit>().likeProduct();
          //         //     //         },
          //         //     //         icon: Icon(
          //         //     //           state ? Icons.favorite : Icons.favorite_border,
          //         //     //           size: 30,
          //         //     //           color: state ? Colors.red : Colors.grey,
          //         //     //         ),
          //         //     //       );
          //         //     //     },
          //         //     //   ),
          //         //     // ),
          //         //     SizedBox(width: 20),
          //         //     Expanded(
          //         //       child: InkWell(
          //         //         onTap: () async {
          //         //           if (state > 0) {
          //         //             final cart = Cart(
          //         //                 name: widget.product.productName!,
          //         //                 price: widget.product.productPrice!.toString(),
          //         //                 description: widget.product.productDescription!,
          //         //                 productImage: widget.product.productImage!,
          //         //                 productId: widget.product.sId!,
          //         //                 quantity: state.toString());

          //         //             await MyDatabase.instance.create(cart);

          //         //             showSnackBar(
          //         //                 context: context,
          //         //                 text: "Cart Added",
          //         //                 type: TopSnackBarType.success);
          //         //           } else {
          //         //             showSnackBar(
          //         //                 context: context,
          //         //                 text:
          //         //                     "Please select the quantity... How much you want!",
          //         //                 type: TopSnackBarType.error);
          //         //           }
          //         //         },
          //         //         child: Container(
          //         //           alignment: Alignment.center,
          //         //           decoration: BoxDecoration(
          //         //             color: kPrimaryColor,
          //         //             borderRadius: BorderRadius.circular(15),
          //         //           ),
          //         //           child: Text(
          //         //             'Add to Cart',
          //         //             style: TextStyle(
          //         //                 color: Colors.white,
          //         //                 fontSize: 15,
          //         //                 fontWeight: FontWeight.bold),
          //         //             // style: GoogleFonts.poppins(
          //         //             //   fontSize: 15,
          //         //             //   fontWeight: FontWeight.w500,
          //         //             //   color: Colors.white,
          //         //             // ),
          //         //           ),

          //         //           //  Obx(
          //         //           //   () =>
          //         //           //       ? SizedBox(
          //         //           //           width: 20,
          //         //           //           height: 20,
          //         //           //           child: CircularProgressIndicator(
          //         //           //             color: Colors.white,
          //         //           //             strokeWidth: 3,
          //         //           //           ),
          //         //           //         )
          //         //           //       : Text(
          //         //           //           '+ Add to Cart',
          //         //           //           // style: GoogleFonts.poppins(
          //         //           //           //   fontSize: 15,
          //         //           //           //   fontWeight: FontWeight.w500,
          //         //           //           //   color: Colors.white,
          //         //           //           // ),
          //         //           //         ),
          //         //           // ),
          //         //         ),
          //         //       ),
          //         //     ),

          //         //   ],
          //         // ),
          //       ),
          //     );
          //   },
          // ),