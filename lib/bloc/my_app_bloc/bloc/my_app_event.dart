part of 'my_app_bloc.dart';

abstract class MyAppEvent extends Equatable {
  const MyAppEvent();

  @override
  List<Object> get props => [];
}

class GetAppInitialEvent extends MyAppEvent {}
