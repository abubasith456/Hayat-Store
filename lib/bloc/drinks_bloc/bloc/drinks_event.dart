part of 'drinks_bloc.dart';

abstract class DrinksEvent extends Equatable {
  const DrinksEvent();

  @override
  List<Object> get props => [];
}

class GetDrinksListEvent extends DrinksEvent {}
