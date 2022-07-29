import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/services/Location/location.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  Completer<GoogleMapController> _controller = Completer();
  AboutUsBloc() : super(AboutUsInitial()) {
    on<AboutUsEvent>((event, emit) async {
      if (event is GoBackEvent) {
        Navigator.pop(event.context);
      }

      if (event is OnMapCreatedEvent) {
        emit(OnMapCreatedState(controller: event.controller));
      }

      if (event is GoToShop) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
            CameraUpdate.newCameraPosition(Location.shopPosition()));
      }
    });
  }
}
