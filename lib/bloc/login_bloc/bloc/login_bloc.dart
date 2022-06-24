import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../api/api_call.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _provider = ApiProvider();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoadingState());
        var loginResponse = await _provider.loginUser();
        emit(LoadedState(loginResponse));
        if (loginResponse.errorMessage != null) {
          emit(ErrorState(loginResponse.errorMessage!));
        }
      } catch (e) {
        print(e);
        emit(ErrorState(e.toString()));
      }
    });
  }
}
