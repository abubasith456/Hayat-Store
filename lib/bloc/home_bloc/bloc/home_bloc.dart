import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiProvider _apiProvider = ApiProvider();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(LoadingHomeState());
        var _productList = await _apiProvider.getProduct();
        List<CategoryModel> _categoryList = await _apiProvider.getCategory();
        if (_productList.error != null) {
          emit(HomeErrorState(_productList.error!, _categoryList[0].error!));
        } else {
          emit(LoadedHomeState(_productList, _categoryList));
        }

        //Image loading
        if (event is LoadImageEvent) {
          // emit(LoadingImageState());
          await Future.delayed(Duration(milliseconds: 500), () {
            emit(LoadedImageState());
          });
        }
      } catch (e) {
        String errorText = "Something went wrong!... ";
        emit(
            HomeErrorState(errorText + e.toString(), errorText + e.toString()));
      }
    });
  }
}
