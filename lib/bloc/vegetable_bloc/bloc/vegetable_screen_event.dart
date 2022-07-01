part of 'vegetable_screen_bloc.dart';

abstract class VegetableScreenEvent extends Equatable {
  const VegetableScreenEvent();

  @override
  List<Object> get props => [];
}

class GetVegetablesEvent extends VegetableScreenEvent {}
