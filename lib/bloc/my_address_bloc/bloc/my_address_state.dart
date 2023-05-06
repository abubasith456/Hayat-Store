part of 'my_address_bloc.dart';

abstract class MyAddressState extends Equatable {
  const MyAddressState();

  @override
  List<Object> get props => [];
}

class MyAddressInitial extends MyAddressState {}

class FetchedMyAddressData extends MyAddressState {
  final List<MyAddress> myAddressList;

  const FetchedMyAddressData({required this.myAddressList});

  @override
  List<Object> get props => [myAddressList];
}

class NoMyAddressDataFound extends MyAddressState {}
