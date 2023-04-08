part of 'orders_admin_bloc.dart';

abstract class OrdersAdminEvent extends Equatable {
  const OrdersAdminEvent();

  @override
  List<Object> get props => [];
}

class FetchOrdersList extends OrdersAdminEvent {}

class AcceptOrderEvent extends OrdersAdminEvent {
  final String userId;
  final String orderId;
  const AcceptOrderEvent({required this.userId, required this.orderId});

  @override
  List<Object> get props => [userId, orderId];
}

class PreparingOrderEvent extends OrdersAdminEvent {
  final String userId;
  final String orderId;
  const PreparingOrderEvent({required this.userId, required this.orderId});

  @override
  List<Object> get props => [userId, orderId];
}

class CancelOrderEvent extends OrdersAdminEvent {
  final String userId;
  final String orderId;
  const CancelOrderEvent({required this.userId, required this.orderId});

  @override
  List<Object> get props => [userId, orderId];
}
