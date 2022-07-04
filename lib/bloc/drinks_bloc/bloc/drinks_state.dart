part of 'drinks_bloc.dart';

abstract class DrinksState extends Equatable {
  const DrinksState();

  @override
  List<Object> get props => [];
}

class DrinksInitial extends DrinksState {}

class DrinksLoadingState extends DrinksState {}

class DrinksLoadedState extends DrinksState {
  ProductModel drinksModel;
  DrinksLoadedState(this.drinksModel);

  @override
  List<Object> get props => [drinksModel];
}

class DrinksErrorState extends DrinksState {
  String error;
  DrinksErrorState(this.error);

  @override
  List<Object> get props => [error];
}
