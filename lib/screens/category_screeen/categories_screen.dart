import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/fruits/fruits_screen.dart';
import '../dairy/dairy_screen.dart';
import '../drinks/drinks_screen.dart';
import '../grocery/grocery_screen.dart';
import '../vegetables/vegetable_screen.dart';

class CategoryScreeen extends StatelessWidget {
  const CategoryScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Category",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: categoryListBottom.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onTap(index, context);
                },
                child: buildImageCard(index, context),
              );
            },
          ),
        ));
  }

  Widget buildImageCard(int index, BuildContext context) => Padding(
        padding: const EdgeInsets.all(7.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                color: Colors.black38,
              ),
              Ink.image(
                image: AssetImage(categoryListBottom[index]['icon']),
                height: 200,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    onTap(index, context);
                  },
                ),
              ),
              Text(
                categoryListBottom[index]['text'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  Widget categoryCard(int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shadowColor: kPrimaryColor,
          elevation: 8,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
              height: 170,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 21, 101, 192), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Stack(
                children: [
                  Text(
                    categoryListBottom[index]['text'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ),
      );

  void onTap(int index, BuildContext context) {
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
            builder: (context) => const GroceryScreen(),
          ));
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DrinksScreen(),
          ));
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FruitsScreen(),
          ));
    } else if (index == 4) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DairyScreen(),
          ));
    }
  }
}
