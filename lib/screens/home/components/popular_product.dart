// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/models/product_model.dart';

// import '../../../util/size_config.dart';
// import 'section_title.dart';

// class PopularProducts extends StatelessWidget {
//   ProductModel? productModel;

//   PopularProducts({required this.productModel});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state is LoadingImageState) {
//           return shimmerWidget(context);
//         } else if (state is LoadedImageState) {
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(20)),
//                 child: SectionTitle(title: "Our Products", press: () {}),
//               ),
//               SizedBox(height: getProportionateScreenWidth(20)),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     ...List.generate(
//                       productModel!.count!,
//                       (index) {
//                         if (true)
//                           return ProductCard(
//                               product: productModel!.products![index]);

//                         return SizedBox
//                             .shrink(); // here by default width and height is 0
//                       },
//                     ),
//                     SizedBox(width: getProportionateScreenWidth(20)),
//                   ],
//                 ),
//               )
//             ],
//           );
//         } else {
//           return shimmerWidget(context);
//         }
//       },
//     );
//   }

//   Widget shimmerWidget(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: getProportionateScreenWidth(20)),
//             child: SectionTitle(title: "Our Products", press: () {}),
//           ),
//           SizedBox(height: getProportionateScreenWidth(20)),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 ...List.generate(
//                   4,
//                   (index) {
//                     if (true)
//                       return ProductCard(
//                           product: productModel!.products![index]);

//                     return SizedBox
//                         .shrink(); // here by default width and height is 0
//                   },
//                 ),
//                 SizedBox(width: getProportionateScreenWidth(20)),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
