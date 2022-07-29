part of 'about_us_bloc.dart';

abstract class AboutUsEvent extends Equatable {
  const AboutUsEvent();

  @override
  List<Object> get props => [];
}

class InitMapValueEvent extends AboutUsEvent {}

class OnMapCreatedEvent extends AboutUsEvent {
  GoogleMapController controller;
  OnMapCreatedEvent({required this.controller});

  @override
  List<Object> get props => [controller];
}

class GoToShop extends AboutUsEvent {}

class GoBackEvent extends AboutUsEvent {
  BuildContext context;
  GoBackEvent(this.context);

  @override
  List<Object> get props => [context];
}
