part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileLoadedSate extends UserProfileState {
  UserProfileModel userProfileModel;
  UserProfileLoadedSate(this.userProfileModel);

  @override
  List<Object> get props => [userProfileModel];
}

class UserProfileError extends UserProfileState {
  String error;
  UserProfileError(this.error);

  @override
  List<Object> get props => [error];
}
