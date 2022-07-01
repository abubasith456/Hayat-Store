import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/models/my_db_model.dart';

import '../../../db/database.dart';

part 'your_cart_bloc_event.dart';
part 'your_cart_bloc_state.dart';

class YourCartBlocBloc extends Bloc<YourCartBlocEvent, YourCartBlocState> {
  YourCartBlocBloc() : super(YourCartBlocInitial()) {
    on<YourCartBlocEvent>((event, emit) async {
      try {
        emit(YourCartBlocInitial());
        var cartList = await MyDatabase.instance.readAllcart();
        double totalPrice = 0;
        cartList.forEach((element) {
          totalPrice +=
              double.parse(element.price) * double.parse(element.quantity);
        });
        if (cartList.isEmpty) {
          emit(YourCartBlocError("Cart is empty"));
        } else
          emit(YourCartBlocLoaded(cartList.length, totalPrice, cartList));
      } catch (e) {
        print(e);
        emit(YourCartBlocError(e.toString()));
      }
    });
  }
}
