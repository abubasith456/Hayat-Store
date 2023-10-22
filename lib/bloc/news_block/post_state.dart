part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final PostModel newsModel;
  const PostLoaded({required this.newsModel});
  @override
  List<Object> get props => [...super.props, newsModel];
}

class PostOnError extends PostState {
  final String error;
  const PostOnError({required this.error});
  @override
  List<Object> get props => [super.props, error];
}
