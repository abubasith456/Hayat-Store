import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/bloc/liked_bloc/bloc/liked_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/likedDB_model.dart';
import 'package:shop_app/screens/fruits/fruits_screen.dart';
import 'package:shop_app/util/connection_lost.dart';
import 'package:shop_app/util/custom_snackbar.dart';

import '../../cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import '../dairy/dairy_screen.dart';
import '../drinks/drinks_screen.dart';
import '../grocery/grocery_screen.dart';
import '../liked_Screeen/components/body.dart';
import '../vegetables/vegetable_screen.dart';

class CategoryScreeen extends StatelessWidget {
  const CategoryScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void refreshCartCount() {
      context.read<YourCartScreenCubit>().getCartData();
    }

    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionSuccess) {
          return Scaffold(
              appBar: AppBar(
                leading: Container(),
                title: Text("Profile"),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: categoryListBottom.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
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
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        elevation: 18,
                        child: Center(
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 55, right: 55, bottom: 60, top: 40),
                                child: SvgPicture.asset(
                                  categoryListBottom[index]['icon'],
                                  color: kPrimaryColor,
                                ),
                              ),
                              Positioned(
                                left: 15,
                                bottom: 10,
                                child: AutoSizeText(
                                  categoryListBottom[index]['text'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )

              // Container(
              //   padding: EdgeInsets.all(10),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   child: ListView.builder(
              //       itemCount: categoryListBottom.length,
              //       itemBuilder: ((context, index) {
              //         return _cardWidgetLiked(context, categoryListBottom, index);
              //       })),
              // ),

              // BlocConsumer<LikedBloc, LikedState>(
              //   listener: (context, state) {
              //     if (state is ErrorLikedState) {
              //       showSnackBar(
              //           context: context,
              //           text: state.error,
              //           type: TopSnackBarType.info);
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is LoadingLikedState) {
              //       return Center(
              //         child: CircularProgressIndicator(color: kPrimaryColor),
              //       );
              //     } else if (state is LoadedLikedState) {
              //       return Container(
              //         padding: EdgeInsets.all(10),
              //         width: MediaQuery.of(context).size.width,
              //         height: MediaQuery.of(context).size.height,
              //         child: ListView.builder(
              //             itemCount: state.likedModel.length,
              //             itemBuilder: ((context, index) {
              //               return _cardWidgetLiked(context, state.likedModel, index);
              //             })),
              //       );
              //     } else {
              //       return Center(
              //         child: CircularProgressIndicator(color: kPrimaryColor),
              //       );
              //     }
              //   },
              // ),
              // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
              );
        } else {
          return ConnectionLostScreen();
        }
      },
    );
  }

  Widget _cardWidgetLiked(BuildContext context,
      List<Map<String, dynamic>> categoriesList, int index) {
    return Card(
      child: ListTile(
        leading: SvgPicture.asset(categoriesList[index]['icon']),
        title: Text(categoriesList[index]['text']),
        // trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
