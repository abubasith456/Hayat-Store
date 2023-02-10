part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {}

class FetchingOrderHistory extends OrderHistoryState {}

class FetchOrderHistorySuccess extends OrderHistoryState {
  final List<OrderHistoryModel> response;
  FetchOrderHistorySuccess({required this.response});

  List<Object> get props => [response];
}

class FetchOrderHistoryFailure extends OrderHistoryState {}

//Cancel order
class OrderCanceling extends OrderHistoryState {}

class OrderCancelSuccess extends OrderHistoryState {}

class OrderCancelFailure extends OrderHistoryState {}

//Delte the order
class OrderDeleting extends OrderHistoryState {}

class OrderDeleteSuccess extends OrderHistoryState {}

class OrderDeleteFailure extends OrderHistoryState {}
