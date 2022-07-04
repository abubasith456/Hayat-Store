import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerListWidget(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          addAutomaticKeepAlives: true,
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 4
                  : 2,
          children: List.generate(10, (index) {
            return Padding(
              padding: const EdgeInsets.all(3),
              child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        textColor: Colors.black,
                        title: Text("Loading"),
                        subtitle: Text("Rs.0"),
                        trailing: Icon(Icons.favorite_outline),
                      ),
                      SizedBox(height: 130, width: 130, child: SizedBox())
                    ],
                  )),
            );
          }),
        ),
      ));
}

Widget cacheShimmer(BuildContext context) {
  return Shimmer.fromColors(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: Container(
        height: 290,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
        child: Container(),
      ),
    ),
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
  );
}
