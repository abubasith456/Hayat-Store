part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceTheOrder extends OrderEvent {
  final List<Cart> listOfProducts;
  final int totalAmount;
  final int userId;
  final String name;
  PlaceTheOrder(
      {required this.name,
      required this.listOfProducts,
      required this.totalAmount,
      required this.userId});

  @override
  List<Object> get props =>
      [...super.props, listOfProducts, totalAmount, userId, name];
}
