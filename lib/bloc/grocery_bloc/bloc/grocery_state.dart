part of 'grocery_bloc.dart';

abstract class GroceryState extends Equatable {
  const GroceryState();

  @override
  List<Object> get props => [];
}

class GroceryInitial extends GroceryState {}

class GroceryLoadingState extends GroceryState {}

class GroceryLoadedState extends GroceryState {
  GroceryModel groceryModel;
  GroceryLoadedState(this.groceryModel);

  @override
  List<Object> get props => [groceryModel];
}

class GroceryErrorState extends GroceryState {
  String error;
  GroceryErrorState(this.error);

  @override
  List<Object> get props => [error];
}
