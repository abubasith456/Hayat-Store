part of 'fruits_bloc.dart';

abstract class FruitsEvent extends Equatable {
  const FruitsEvent();

  @override
  List<Object> get props => [];
}

class GetFruitsListEvent extends FruitsEvent {}
