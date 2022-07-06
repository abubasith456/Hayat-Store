part of 'liked_bloc.dart';

abstract class LikedState extends Equatable {
  const LikedState();

  @override
  List<Object> get props => [];
}

class LikedInitial extends LikedState {}

class LoadingLikedState extends LikedState {}

class LoadedLikedState extends LikedState {
  List<Liked> likedModel;
  LoadedLikedState(this.likedModel);

  @override
  List<Object> get props => [likedModel];
}

class ErrorLikedState extends LikedState {
  String error;
  ErrorLikedState(this.error);

  @override
  List<Object> get props => [error];
}
