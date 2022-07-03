import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/grocery_model.dart';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  ApiProvider _apiProvider = ApiProvider();
  GroceryBloc() : super(GroceryInitial()) {
    on<GroceryEvent>((event, emit) async {
      try {
        if (event is GetGroceryListEvent) {
          emit(GroceryLoadingState());
          var _groceryList = await _apiProvider.getGroceryItems();
          if (_groceryList.error != null) {
            emit(GroceryErrorState(_groceryList.error!));
          } else {
            emit(GroceryLoadedState(_groceryList));
          }
        }
      } catch (e) {
        emit(GroceryErrorState(e.toString()));
      }
    });
  }
}
