import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/bloc/dairy_bloc/bloc/dairy_bloc.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/screens/dairy/dairy_screen.dart';
import 'package:shop_app/screens/drinks/drinks_screen.dart';
import 'package:shop_app/screens/fruits/fruits_screen.dart';
import 'package:shop_app/screens/grocery/grocery_screen.dart';

import '../../../constants.dart';
import '../../../util/size_config.dart';
import '../../vegetables/vegetable_screen.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void refreshCartCount() {
      context.read<YourCartScreenCubit>().getCartData();
    }

    return Container(
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
                  press: () async {
                    if (index == 0) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VegetableScreen(),
                          ));
                      refreshCartCount();
                    } else if (index == 1) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroceryScreen(),
                          ));
                      refreshCartCount();
                    } else if (index == 2) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DrinksScreen(),
                          ));
                      refreshCartCount();
                    } else if (index == 3) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FruitsScreen(),
                          ));
                      refreshCartCount();
                    } else if (index == 4) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DairyScreen(),
                          ));
                      refreshCartCount();
                    }
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    // required this.categoryModel
  }) : super(key: key);

  final String? icon, text;
  final VoidCallback press;
  // final CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                height: getProportionateScreenWidth(55),
                width: getProportionateScreenWidth(55),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  icon!,
                  color: Colors.white,
                )),
            SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
