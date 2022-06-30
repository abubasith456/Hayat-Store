import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../api/api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _provider = ApiProvider();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        if (event is LoginUser) {
          emit(LoadingState());
          var loginResponse =
              await _provider.loginUser(event.email, event.password);

          emit(LoadedState(loginResponse));
          if (loginResponse.error != null) {
            emit(ErrorState(loginResponse.error!));
          }
        }
      } catch (e) {
        print(e);
        emit(ErrorState(e.toString()));
      }
    });
  }
}
