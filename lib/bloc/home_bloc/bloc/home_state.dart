part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingProductState extends HomeState {}

// ignore: must_be_immutable
class LoadedProductState extends HomeState {
  ProductModel productModel;
  LoadedProductState(this.productModel);
}

class ProductErrorState extends HomeState {
  String error;
  ProductErrorState(this.error);
}
