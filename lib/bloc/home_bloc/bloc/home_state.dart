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
}

class HomeErrorState extends HomeState {
  String ProductError;
  String CategoryError;
  HomeErrorState(this.ProductError, this.CategoryError);
}
