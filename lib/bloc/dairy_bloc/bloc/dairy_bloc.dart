import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/product_model.dart';

part 'dairy_event.dart';
part 'dairy_state.dart';

class DairyBloc extends Bloc<DairyEvent, DairyState> {
  ApiProvider _apiProvider = ApiProvider();
  DairyBloc() : super(DairyInitial()) {
    on<DairyEvent>((event, emit) async {
      try {
        if (event is GetDairyListEvent) {
          emit(DairyLoadingState());
          var _dairyList = await _apiProvider.getDairyItems();
          if (_dairyList.error != null) {
            emit(DairyErrorState(_dairyList.error!));
          } else {
            emit(DairyLoadedState(_dairyList));
          }
        }
      } catch (e) {
        emit(DairyErrorState(e.toString()));
      }
    });
  }
}
