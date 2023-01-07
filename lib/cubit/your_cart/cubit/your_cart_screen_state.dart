part of 'your_cart_screen_cubit.dart';

enum YourCartState { initial, loaded, error }

// abstract class YourCartScreenState extends Equatable {
//   const YourCartScreenState();

//   @override
//   List<Object> get props => [];
// }

// class YourCartScreenInitial {
//   // YourCartScreenInitial(this.items);
// }

class YourCartItemCount extends Equatable {
  final int item;
  final List<Cart> cartList;
  final double totalAmount;
  YourCartState state = YourCartState.initial;
  YourCartItemCount(
      {required this.item,
      required this.totalAmount,
      required this.state,
      required this.cartList});

  YourCartItemCount copywith({
    cartList,
    state,
    item,
    totalAmount,
  }) {
    return YourCartItemCount(
      cartList: cartList ?? this.cartList,
      state: state ?? this.state,
      item: item ?? this.item,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object> get props => [item, totalAmount, state];
}
