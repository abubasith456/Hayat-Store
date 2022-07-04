part of 'fruits_bloc.dart';

abstract class FruitsState extends Equatable {
  const FruitsState();

  @override
  List<Object> get props => [];
}

class FruitsInitial extends FruitsState {}

class FruitsLoadingState extends FruitsState {}

class FruitsLoadedState extends FruitsState {
  ProductModel fruitsModel;
  FruitsLoadedState(this.fruitsModel);

  @override
  List<Object> get props => [fruitsModel];
}

class FruitsErrorState extends FruitsState {
  String error;
  FruitsErrorState(this.error);

  @override
  List<Object> get props => [error];
}
