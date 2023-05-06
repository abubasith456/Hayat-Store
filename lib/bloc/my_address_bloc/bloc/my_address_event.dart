part of 'my_address_bloc.dart';

abstract class MyAddressEvent extends Equatable {
  const MyAddressEvent();

  @override
  List<Object> get props => [];
}

class GetMyAddressData extends MyAddressEvent {}
