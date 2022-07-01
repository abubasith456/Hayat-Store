part of 'your_cart_bloc_bloc.dart';

abstract class YourCartBlocEvent extends Equatable {
  const YourCartBlocEvent();

  @override
  List<Object> get props => [];
}

class GetCartDBEvent extends YourCartBlocEvent {}
