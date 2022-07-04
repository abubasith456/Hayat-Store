part of 'dairy_bloc.dart';

abstract class DairyEvent extends Equatable {
  const DairyEvent();

  @override
  List<Object> get props => [];
}

class GetDairyListEvent extends DairyEvent {}
