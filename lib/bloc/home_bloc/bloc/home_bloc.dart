import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_call.dart';
import 'package:shop_app/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiProvider _apiProvider = ApiProvider();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(LoadingProductState());
        var _productList = await _apiProvider.getProduct();
        emit(LoadedProductState(_productList));
        if (_productList.error != null) {
          emit(ProductErrorState(_productList.error!));
        }
      } catch (e) {
        emit(ProductErrorState("Something went wrong!... " + e.toString()));
      }
    });
  }
}
