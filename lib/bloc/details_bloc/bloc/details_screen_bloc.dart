import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'details_screen_event.dart';
part 'details_screen_state.dart';

class DetailsScreenBloc extends Bloc<DetailsScreenEvent, DetailsScreenState> {
  late double value = 0;
  DetailsScreenBloc() : super(DetailsScreenInitial()) {
    on<DetailsScreenEvent>((event, emit) {
      if (event is IncreaseCountEvent) {
        emit(IncreaseCountState(value++));
      } else if (event is DecreaseCountEvent) {
        emit(DecreaseCountState(value--));
      }
    });
  }
}
