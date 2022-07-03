import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/util/init_check.dart';

part 'my_app_event.dart';
part 'my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(MyAppInitial()) {
    on<MyAppEvent>((event, emit) async {
      try {
        if (event is GetAppInitialEvent) {
          emit(LoadingMyAppState());
          var _initialChecking = InitialChecking.instance;
          await _initialChecking.getIsLogged();
          emit(LoadedMyAppState(
              _initialChecking.isLogged, _initialChecking.isNotShowWelcome));
        }
      } catch (e) {
        emit(ErrorMyAppState(e.toString()));
      }
    });
  }
}
