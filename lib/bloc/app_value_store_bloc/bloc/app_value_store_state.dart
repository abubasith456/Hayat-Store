part of 'app_value_store_bloc.dart';

abstract class AppValueStoreState extends Equatable {
  const AppValueStoreState();
  
  @override
  List<Object> get props => [];
}

class AppValueStoreInitial extends AppValueStoreState {}
