import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_value_store_event.dart';
part 'app_value_store_state.dart';

class AppValueStoreBloc extends Bloc<AppValueStoreEvent, AppValueStoreState> {
  AppValueStoreBloc() : super(AppValueStoreInitial()) {
    on<AppValueStoreEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
