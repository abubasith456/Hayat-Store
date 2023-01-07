part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderErrorState extends OrderState {}

class OrderPlaced extends OrderState {
  final OrdersNewModel orderdItemModel;
  OrderPlaced({required this.orderdItemModel});
  @override
  List<Object> get props => [...super.props, orderdItemModel];
}
