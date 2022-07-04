import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/fruit_model.dart';
import 'package:shop_app/models/product_model.dart';

part 'fruits_event.dart';
part 'fruits_state.dart';

class FruitsBloc extends Bloc<FruitsEvent, FruitsState> {
  ApiProvider _apiProvider = ApiProvider();
  FruitsBloc() : super(FruitsInitial()) {
    on<FruitsEvent>((event, emit) async {
      try {
        if (event is GetFruitsListEvent) {
          emit(FruitsLoadingState());
          var _fruitsList = await _apiProvider.getFruitsItems();
          print(_fruitsList);

          if (_fruitsList.error != null) {
            emit(FruitsErrorState(_fruitsList.error!));
          } else {
            emit(FruitsLoadedState(_fruitsList));
          }
        }
      } catch (e) {
        emit(FruitsErrorState(e.toString()));
      }
    });
  }
}
