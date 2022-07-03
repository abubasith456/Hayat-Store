part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {}

class ConnectionSuccess extends NetworkState {}

class ConnectionFailure extends NetworkState {}
