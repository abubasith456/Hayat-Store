import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../models/product_model.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Products product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

String baseurl = "https://hidden-waters-80713.herokuapp.com/";
String formater(String url) {
  return baseurl + url;
}

NetworkImage getImage(String imageName) {
  String url = formater(imageName);
  return NetworkImage(url);
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.sId.toString(),
              child: Image(image: getImage(widget.product.productImage!)),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(widget.product.productImage!.length,
        //         (index) => buildSmallProductPreview(index)),
        //   ],
        // )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(widget.product.productImage![index]),
      ),
    );
  }
}
