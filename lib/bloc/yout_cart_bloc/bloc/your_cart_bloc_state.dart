part of 'your_cart_bloc_bloc.dart';

abstract class YourCartBlocState extends Equatable {
  YourCartBlocState();

  @override
  List<Object> get props => [];
}

class YourCartBlocInitial extends YourCartBlocState {}

class YourCartBlocLoaded extends YourCartBlocState {
  int itemCount;
  double totalPrice;
  List<Cart> cartList;

  YourCartBlocLoaded(this.itemCount, this.totalPrice, this.cartList);

  @override
  List<Object> get props => [itemCount, totalPrice, cartList];

  // YourCartBlocLoaded copywith({
  //   cartList,
  //   itemCount,
  //   totalPrice,
  // }) {
  //   return YourCartBlocLoaded(
  //     cartList: cartList ?? this.cartList,
  //     itemCount: itemCount ?? this.itemCount,
  //     totalPrice: totalPrice ?? this.totalPrice,
  //   );
  // }
}

class YourCartBlocError extends YourCartBlocState {
  String error;
  YourCartBlocError(this.error);

  @override
  List<Object> get props => [error];
}
