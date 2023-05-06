import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/models/my_address_model.dart';
import 'package:shop_app/models/user_db_model.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';

part 'my_address_event.dart';
part 'my_address_state.dart';

class MyAddressBloc extends Bloc<MyAddressEvent, MyAddressState> {
  MyAddressBloc() : super(MyAddressInitial()) {
    on<MyAddressEvent>((event, emit) async {
      if (event is GetMyAddressData) {
        List<MyAddress> myAddressList = await UserDb.instance.readAllAddress(
            userId: sl<SharedPrefService>().getData(userIdKey).toString());

        if (kDebugMode) {
          print("DB called....");
        }

        if (myAddressList.isNotEmpty) {
          emit(FetchedMyAddressData(myAddressList: myAddressList));
        } else {
          emit(NoMyAddressDataFound());
        }
      }
    });
  }
}
