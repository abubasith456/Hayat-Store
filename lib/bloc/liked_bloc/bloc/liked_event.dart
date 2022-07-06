part of 'liked_bloc.dart';

abstract class LikedEvent extends Equatable {
  const LikedEvent();

  @override
  List<Object> get props => [];
}

class GetLikedDBEvent extends LikedEvent {}

class LikeProductEvent extends LikedEvent {
  Liked likedModel;
  LikeProductEvent(this.likedModel);
  @override
  List<Object> get props => [likedModel];
}

class DisLikeProductEvent extends LikedEvent {
  Liked likedModel;
  DisLikeProductEvent(this.likedModel);
  @override
  List<Object> get props => [likedModel];
}
