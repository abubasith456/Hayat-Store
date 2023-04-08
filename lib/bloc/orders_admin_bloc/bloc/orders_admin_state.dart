part of 'orders_admin_bloc.dart';

abstract class OrdersAdminState extends Equatable {
  const OrdersAdminState();

  @override
  List<Object> get props => [];
}

class OrdersAdminInitial extends OrdersAdminState {}

class FetchOrdersForAdmin extends OrdersAdminState {}

class FetchOrderForAdminSuccess extends OrdersAdminState {
  final List<OrderHistoryModel> ordersList;
  const FetchOrderForAdminSuccess({required this.ordersList});
  @override
  List<Object> get props => [];
}

class FetchOrdersForAdminFailed extends OrdersAdminState {}

//Success
class OrdersFetched extends OrdersAdminState {}

// Acepting Order
class AcceptingOrder extends OrdersAdminState {}

class AcceptingSuccess extends OrdersAdminState {}

class AcceptingError extends OrdersAdminState {
  final String error;
  const AcceptingError({required this.error});
  @override
  List<Object> get props => [error];
}

//Preparing Order

class PreparingOrder extends OrdersAdminState {}

class PreparingSuccess extends OrdersAdminState {}

class PreparingError extends OrdersAdminState {
  final String error;
  const PreparingError({required this.error});
  @override
  List<Object> get props => [error];
}

// Canceling Order
class CancellingOrder extends OrdersAdminState {}

class CancellingSuccess extends OrdersAdminState {}

class CancellingError extends OrdersAdminState {
  final String error;
  const CancellingError({required this.error});
  @override
  List<Object> get props => [error];
}

// Canceling Order
class DeliveringOrder extends OrdersAdminState {}

class DeliveredOrderSuccess extends OrdersAdminState {}

class DeliveringError extends OrdersAdminState {
  final String error;
  const DeliveringError({required this.error});
  @override
  List<Object> get props => [error];
}
