part of 'firebase_cubit.dart';

abstract class FirebaseState extends Equatable {
  const FirebaseState();

  @override
  List<Object> get props => [];
}

class FirebaseInitial extends FirebaseState {}

class PushTokenStoringState extends FirebaseState {}

class PushTokenStoredState extends FirebaseState {}
