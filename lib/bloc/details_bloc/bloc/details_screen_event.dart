part of 'details_screen_bloc.dart';

abstract class DetailsScreenEvent extends Equatable {
  const DetailsScreenEvent();

  @override
  List<Object> get props => [];
}

class IncreaseCountEvent extends DetailsScreenEvent {
  // double value;
  // IncreaseCountEvent(this.value);
}

class DecreaseCountEvent extends DetailsScreenEvent {
  // double value;
  // DecreaseCountEvent(this.value);
}

class CheckOutButtonEvent extends DetailsScreenEvent {}
