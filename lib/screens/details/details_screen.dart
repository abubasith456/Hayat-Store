import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/details_bloc/bloc/details_screen_bloc.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/vegetables_model.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import '../../constants.dart';
import '../../cubit/cart_counter/cart_counter_cubit.dart';
import '../../db/database.dart';
import '../../models/my_db_model.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  NetworkImage getImage(String imageUrl) {
    String url = imageLoadUrl + imageUrl;
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
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
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .35,
              padding: const EdgeInsets.only(bottom: 30),
              color: kPrimaryColor,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imageLoadUrl + agrs.product.productImage!,
                placeholder: (context, url) => Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.image_search_outlined),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image_search_outlined),
              ),
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
                                '${agrs.product.productName}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\Rs.${agrs.product.productPrice}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Text(
                            '${agrs.product.productDescription}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
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
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final cart = Cart(
                            name: agrs.product.productName!,
                            price: agrs.product.productPrice!.toString(),
                            description: agrs.product.productDescription!,
                            productImage: agrs.product.productImage!,
                            productId: agrs.product.sId!,
                            quantity: state.toString());

                        await MyDatabase.instance.create(cart);
                        await context.read<YourCartScreenCubit>().getCartData();

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
                        ),
                      ),
                    ),
                  )
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

  // @override
  // Widget build(BuildContext context) {
  //   final ProductDetailsArguments agrs =
  //       ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;

  //   return BlocProvider(
  //     create: (context) => CartCounterCubit(),
  //     child: WillPopScope(
  //       onWillPop: () async => false,
  //       child: Scaffold(
  //         backgroundColor: Color(0xFFF5F6F9),
  //         appBar: PreferredSize(
  //           preferredSize: Size.fromHeight(AppBar().preferredSize.height),
  //           child: CustomAppBar(rating: 1.1),
  //         ),
  //         body: Body(product: agrs.product),
  //       ),
  //     ),
  //   );
  // }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
