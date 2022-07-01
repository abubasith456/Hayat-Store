part of 'vegetable_screen_bloc.dart';

abstract class VegetableScreenState extends Equatable {
  const VegetableScreenState();

  @override
  List<Object> get props => [];
}

class VegetableScreenInitial extends VegetableScreenState {}

class VegetableScreenLoadingState extends VegetableScreenState {}

class VegetableScreenLoadedState extends VegetableScreenState {
  VegetablesModel vegetablesModel;

  VegetableScreenLoadedState(this.vegetablesModel);

  @override
  List<Object> get props => [vegetablesModel];
}

class VegetableScreenErrorState extends VegetableScreenState {
  String error;
  VegetableScreenErrorState(this.error);

  @override
  List<Object> get props => [error];
}
