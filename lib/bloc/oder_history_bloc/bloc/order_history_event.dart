part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchHistoryList extends OrderHistoryEvent {}

class CancelOrderEvent extends OrderHistoryEvent {
  final String orderId;
  CancelOrderEvent({required this.orderId});

  List<Object> get props => [orderId];
}

class DeleteOrderEvent extends OrderHistoryEvent {
  final String orderId;
  DeleteOrderEvent({required this.orderId});

  List<Object> get props => [orderId];
}


