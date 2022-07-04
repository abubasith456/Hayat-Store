part of 'dairy_bloc.dart';

abstract class DairyState extends Equatable {
  const DairyState();

  @override
  List<Object> get props => [];
}

class DairyInitial extends DairyState {}

class DairyLoadingState extends DairyState {}

class DairyLoadedState extends DairyState {
  ProductModel dairyModel;
  DairyLoadedState(this.dairyModel);

  @override
  List<Object> get props => [dairyModel];
}

class DairyErrorState extends DairyState {
  String error;
  DairyErrorState(this.error);

  @override
  List<Object> get props => [error];
}
