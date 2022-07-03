import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/screens/drinks/drinks_screen.dart';
import 'package:shop_app/screens/grocery/grocery_screen.dart';

import '../../../util/size_config.dart';
import '../../vegetables/vegetable_screen.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/vegetablesIcon.svg", "text": "Vegetables"},
      {"icon": "assets/icons/groceryIcon.svg", "text": "Grocery"},
      {"icon": "assets/icons/drinksIcon.svg", "text": "Drinks"},
      {"icon": "assets/icons/fruitsIcon.svg", "text": "Fruits"},
      {"icon": "assets/icons/dairy.svg", "text": "Dairy"},
    ];
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
                  press: () {
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VegetableScreen(),
                          ));
                    } else if (index == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroceryScreen(),
                          ));
                    } else if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DrinksScreen(),
                          ));
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
                  color: Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon!)),
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
