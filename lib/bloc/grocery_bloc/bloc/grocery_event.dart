part of 'grocery_bloc.dart';

abstract class GroceryEvent extends Equatable {
  const GroceryEvent();

  @override
  List<Object> get props => [];
}

class GetGroceryListEvent extends GroceryEvent {}
