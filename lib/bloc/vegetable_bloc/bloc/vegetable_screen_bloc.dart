import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/vegetables_model.dart';

part 'vegetable_screen_event.dart';
part 'vegetable_screen_state.dart';

class VegetableScreenBloc
    extends Bloc<VegetableScreenEvent, VegetableScreenState> {
  final ApiProvider _apiProvider = ApiProvider();
  VegetableScreenBloc() : super(VegetableScreenInitial()) {
    on<VegetableScreenEvent>((event, emit) async {
      try {
        if (event is GetVegetablesEvent) {
          emit(VegetableScreenLoadingState());
          var _vegetableList = await _apiProvider.getVegetables();
          if (_vegetableList.error != null) {
            emit(VegetableScreenErrorState(_vegetableList.error!));
          } else {
            emit(VegetableScreenLoadedState(_vegetableList));
          }
        }
      } catch (e) {
        print(e);
        emit(VegetableScreenErrorState(e.toString()));
      }
    });
  }
}
