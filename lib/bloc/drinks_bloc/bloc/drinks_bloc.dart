import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/drinks_model.dart';
import 'package:shop_app/models/product_model.dart';

part 'drinks_event.dart';
part 'drinks_state.dart';

class DrinksBloc extends Bloc<DrinksEvent, DrinksState> {
  ApiProvider _apiProvider = ApiProvider();
  DrinksBloc() : super(DrinksInitial()) {
    on<DrinksEvent>((event, emit) async {
      try {
        if (event is GetDrinksListEvent) {
          emit(DrinksLoadingState());
          var _drinksList = await _apiProvider.getDrinksItems();
          if (_drinksList.error != null) {
            emit(DrinksErrorState(_drinksList.error!));
          } else {
            emit(DrinksLoadedState(_drinksList));
          }
        }
      } catch (e) {
        emit(DrinksErrorState(e.toString()));
      }
    });
  }
}
