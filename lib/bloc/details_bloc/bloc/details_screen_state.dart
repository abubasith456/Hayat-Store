part of 'details_screen_bloc.dart';

abstract class DetailsScreenState extends Equatable {
  const DetailsScreenState();

  @override
  List<Object> get props => [];
}

class DetailsScreenInitial extends DetailsScreenState {}

class IncreaseCountState extends DetailsScreenState {
  double increasedValue;
  IncreaseCountState(this.increasedValue);

  @override
  List<Object> get props => [increasedValue];
}

class DecreaseCountState extends DetailsScreenState {
  double decreasedBValue;
  DecreaseCountState(this.decreasedBValue);

  @override
  List<Object> get props => [decreasedBValue];
}
