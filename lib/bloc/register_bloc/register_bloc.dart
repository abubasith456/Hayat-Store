import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/cubit/cubit/register_cubit.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/temp_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  var apiCall = ApiProvider();
  RegisterBloc(BuildContext context) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        if (event is RegisterButtonPressed) {
          emit(RegisterLoading());

          // String username = context.read<RegisterCubit>().state.userame;
          // String dateOfBirth = context.read<RegisterCubit>().state.dateOfBirth;
          // String mobileNumber =
          //     context.read<RegisterCubit>().state.mobilenumber;
          // String password = context.read<RegisterCubit>().state.password;
          // String cnfrmPass = context.read<RegisterCubit>().state.cnfrmPassword;

          Map<String, dynamic> mapRegister = {
            "email": event.email,
            "username": event.username,
            "dateOfBirth": event.dateOfBirth,
            "mobileNumber": event.mobileNumber,
            "password": event.password,
            "passwordConf": event.cnfrmPassword,
          };

          print(mapRegister);

          var regsierData = await apiCall.registerUser(mapRegister);

          emit(RegisterLoaded(regsierData));
        }
      } catch (e) {
        print(e.toString());
        emit(await RegsiterError(e.toString()));
      }
    });
  }
}
