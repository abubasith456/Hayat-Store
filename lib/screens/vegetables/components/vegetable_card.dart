import 'package:flutter/material.dart';
import 'package:shop_app/models/vegetables_model.dart';

import '../../../constants.dart';
import '../../../models/my_db_model.dart';
import '../../../util/size_config.dart';
import '../../details/details_screen.dart';

class VegetableCard extends StatelessWidget {
  const VegetableCard({
    Key? key,
    required this.vegetable,
  }) : super(key: key);

  final VegetableProducts vegetable;

  @override
  Widget build(BuildContext context) {
    String baseurl = "https://hidden-waters-80713.herokuapp.com/";
    String formater(String url) {
      return baseurl + url;
    }

    NetworkImage getImage(String imageName) {
      String url = formater(imageName);
      return NetworkImage(url);
    }

    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //       context,
        //       DetailsScreen.routeName,
        //       arguments: ProductDetailsArguments(product: product!),
        //     ),
      },
      child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            children: [
              ListTile(
                textColor: Colors.black,
                title: Text(vegetable.name!),
                subtitle: Text("Rs.${vegetable.price}"),
                trailing: Icon(Icons.favorite_outline),
              ),
              SizedBox(
                height: 130,
                width: 130,
                child: Image(
                  image: getImage(vegetable.vegetableImage!),
                ),
              )
              // Container(
              //   height: 200,
              //   width: 300,
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.all(10),
              //   child: Ink.image(
              //     image: getImage(vegetable.vegetableImage!),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.all(16.0),
              //   alignment: Alignment.centerLeft,
              //   child: Text(""),
              // ),
              // ButtonBar(
              //   children: [
              //     TextButton(
              //       child: const Text('CONTACT AGENT'),
              //       onPressed: () {/* ... */},
              //     ),
              //     TextButton(
              //       child: const Text('LEARN MORE'),
              //       onPressed: () {/* ... */},
              //     )
              //   ],
              // )
            ],
          )

          //  Row(
          //   children: [
          //     SizedBox(
          //       width: 88,
          //       child: AspectRatio(
          //         aspectRatio: 0.88,
          //         child: Container(
          //           padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          //           decoration: BoxDecoration(
          //             color: kSecondaryColor.withOpacity(0.1),
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           child: Hero(
          //               tag: vegetable.sId!,
          //               child: Image(
          //                 image: getImage(vegetable.vegetableImage!),
          //                 fit: BoxFit.cover,
          //               )),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 20),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           vegetable.name!,
          //           style: TextStyle(color: Colors.black, fontSize: 16),
          //           maxLines: 2,
          //         ),
          //         SizedBox(height: 10),
          //         Text.rich(
          //           TextSpan(
          //             text: "\Rs.${vegetable.price}",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w600, color: kPrimaryColor),
          //             children: [
          //               // TextSpan(
          //               //     //Number of item
          //               //     text: " x${cart.quantity}",
          //               //     style: Theme.of(context).textTheme.bodyText1),
          //             ],
          //           ),
          //         )
          //       ],
          //     )
          //   ],
          // ),
          ),
    );
  }
}
