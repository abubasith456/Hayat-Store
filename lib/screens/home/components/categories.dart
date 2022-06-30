import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/models/category_model.dart';

import '../../../util/size_config.dart';

class Categories extends StatelessWidget {
  List<CategoryModel>? categoryModel;

  Categories({required this.categoryModel});
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categoryModel!.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryCard(
                  icon: categoryModel![index].icon,
                  text: categoryModel![index].name,
                  categoryModel: categoryModel![index],
                  press: () {},
                ),
              ),
            ),
          ),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      required this.icon,
      required this.text,
      required this.press,
      required this.categoryModel})
      : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;
  final CategoryModel? categoryModel;

  IconData getIcon(String name) {
    if (name == "Mobile") {
      return Icons.send_to_mobile_rounded;
    } else if (name == "Vegetables") {
      return Icons.forest_sharp;
    } else if (name == "Fruites") {
      return Icons.flatware_outlined;
    } else if (name == "Juice") {
      return Icons.coffee;
    } else if (name == "Grocery") {
      return Icons.shop;
    } else {
      return Icons.shop;
    }
  }

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
              child: Tab(
                icon: Icon(getIcon(categoryModel!.icon!)),
              ),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
