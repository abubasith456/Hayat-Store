part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetProductListEvent extends HomeEvent {
  final BuildContext context;
  GetProductListEvent({required this.context});

  List<Object> get props => [context];
}

class LoadImageEvent extends HomeEvent {}
