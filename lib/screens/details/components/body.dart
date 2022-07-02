import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/details_bloc/bloc/details_screen_bloc.dart';
import 'package:shop_app/components/default_button.dart';

import 'package:shop_app/db/database.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/my_db_model.dart';
import 'package:shop_app/util/size_config.dart';
import '../../../constants.dart';
import '../../../cubit/cart_counter/cart_counter_cubit.dart';
import '../../../models/product_model.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Products product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: ListView(
                children: [
                  ProductImages(product: widget.product),
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ProductDescription(
                          product: widget.product,
                          pressOnSeeMore: () {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: _shoppingItem(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // TopRoundedContainer(
                        //     color: Color(0xFFF6F7F9), child: _shoppingItem(context)
                        //     // Column(
                        //     //   crossAxisAlignment: CrossAxisAlignment.center,
                        //     //   mainAxisSize: MainAxisSize.max,
                        //     //   mainAxisAlignment: MainAxisAlignment.end,
                        //     //   children: [
                        //     //     _shoppingItem(context)
                        //     //     // ColorDots(product: product!),
                        //     //   ],
                        //     // ),
                        //     ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: kPrimaryColor,
                  ),
                  onPressed: () async {
                    final cart = Cart(
                        name: widget.product.name!,
                        price: widget.product.price!.toString(),
                        description: widget.product.description!,
                        productImage: widget.product.productImage!,
                        productId: widget.product.sId!,
                        quantity:
                            context.read<CartCounterCubit>().state.toString());

                    await MyDatabase.instance.create(cart);
                  },
                  child:
                      // false
                      //     ? CircularProgressIndicator(
                      //         color: Colors.white,
                      //       )
                      //     :
                      Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _shoppingItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                width: 5,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _incrementButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        context.read<CartCounterCubit>().increment();
      },
    );
  }

  Widget _decrementButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          context.read<CartCounterCubit>().decrement();
        },
        child: Icon(Icons.remove, color: Colors.black),
        backgroundColor: Colors.white);
  }
}
