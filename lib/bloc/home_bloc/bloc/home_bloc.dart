import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/services/Location/location.dart';
import 'package:shop_app/services/firebase_push/firebase_push.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/permission/permission.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';
import 'package:shop_app/util/shared_pref.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiProvider _apiProvider = ApiProvider();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetProductListEvent) {
        try {
          emit(LoadingHomeState());

          _getAddressDetailsGeo();

          var _productList = await _apiProvider.getProduct();

          // List<CategoryModel> _categoryList = await _apiProvider.getCategory();
          storeAreaAddress(BuildContext context, bool isManditory) async {}

          if (_productList.error != null) {
            emit(HomeErrorState(_productList.error!));
            await storeAreaAddress(event.context, false);
          } else {
            emit(LoadedHomeState(_productList));
            await storeAreaAddress(event.context, false);
          }

          //Image loading
          if (event is LoadImageEvent) {
            // emit(LoadingImageState());
            await Future.delayed(Duration(milliseconds: 500), () {
              emit(LoadedImageState());
            });
          }
          //Set the push token after login
          sePushtoken(event.context);
        } catch (e) {
          String errorText = "Something went wrong!... ";
          emit(HomeErrorState(errorText + e.toString()));
        }
      }
    });
  }
}

_getAddressDetailsGeo() {
  try {
    sl<PermissionService>().getLocationPermission().then((value) async {
      if (value) {
        print("getLocationPermission caled ===> ");
        await sl<LocationService>().determinePosition().then((position) async {
          print("determinePosition caled ===> ");
          sl<LocationService>().getAdressDetailsFromGeo(position);
        });
      } else {
        return;
      }
    });
  } catch (e) {
    print(e);
    return;
  }
}
