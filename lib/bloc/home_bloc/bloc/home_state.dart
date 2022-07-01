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
  List<CategoryModel> categoryModel;
  LoadedHomeState(this.productModel, this.categoryModel);

  @override
  List<Object> get props => [productModel, categoryModel];
}

// ignore: must_be_immutable
class HomeErrorState extends HomeState {
  String productError;
  String categoryError;
  HomeErrorState(this.productError, this.categoryError);

  // @override
  // List<Object> get props => [productError, categoryError];
}
