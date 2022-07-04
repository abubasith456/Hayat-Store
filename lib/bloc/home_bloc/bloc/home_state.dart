part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingHomeState extends HomeState {}

// ignore: must_be_immutable
class LoadedHomeState extends HomeState {
  ProductModel productModel;
  LoadedHomeState(this.productModel);

  @override
  List<Object> get props => [productModel];
}

class LoadingImageState extends HomeState {}

class LoadedImageState extends HomeState {}

// ignore: must_be_immutable
class HomeErrorState extends HomeState {
  String productError;
  HomeErrorState(this.productError);

  @override
  List<Object> get props => [productError];
}
