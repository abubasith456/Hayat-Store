import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/models/my_db_model.dart';

import '../../../db/database.dart';

part 'your_cart_screen_state.dart';

class YourCartScreenCubit extends Cubit<YourCartItemCount> {
  YourCartScreenCubit()
      : super(YourCartItemCount(
            item: 0,
            totalAmount: 0,
            state: YourCartState.initial,
            cartList: []));

  //  List<Cart> cartList = await MyDatabase.instance.readAllcart();

  // void getItemCount() => emit(state);
  // void getCartItem() async =>
  //     emit(state.copywith(cartList: await MyDatabase.instance.readAllcart()));
  // void currentItemCount(int value) => emit(state.copywith(item: value));
  // void totalAmountCount(double valid) =>
  //     emit(state.copywith(totalAmount: valid));
  // void currentItemcountDecrease(int value) =>
  //     emit(state.copywith(item: value--));

  getCartData() async {
    List<Cart> cartList = await MyDatabase.instance.readAllcart();
    print(cartList.length);
    double totalPrice = 0;
    cartList.forEach((element) {
      totalPrice +=
          double.parse(element.price) * double.parse(element.quantity);
    });
    emit(state.copywith(
        item: cartList.length,
        totalAmount: totalPrice,
        cartList: cartList,
        state: YourCartState.loaded));
  }

  deleteCart(int id) async {
    await MyDatabase.instance.delete(id);
    getCartData();
  }
}
