import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';

import '../../../constants.dart';

part 'orders_admin_event.dart';
part 'orders_admin_state.dart';

class OrdersAdminBloc extends Bloc<OrdersAdminEvent, OrdersAdminState> {
  OrdersAdminBloc() : super(OrdersAdminInitial()) {
    var api = ApiProvider();
    on<OrdersAdminEvent>((event, emit) async {
      if (event is FetchOrdersList) {
        var response = await api.getAllOrders();

        if (response.isEmpty) {
          emit(FetchOrdersForAdminFailed());
        } else {
          List<OrderHistoryModel> responselist =
              response.map((e) => OrderHistoryModel.fromJson(e)).toList();
          emit(FetchOrderForAdminSuccess(ordersList: responselist));
        }
      }

      if (event is AcceptOrderEvent) {
        emit(AcceptingOrder());
        var status = "Accepted";
        var response =
            await api.changeOrderStatus(event.orderId, event.userId, status);

        if (response.error != null) {
          emit(AcceptingError(error: response.error!));
        } else {
          emit(AcceptingSuccess());
        }
      }

      if (event is PreparingOrderEvent) {
        emit(PreparingOrder());
        var status = "Preparing";
        var response =
            await api.changeOrderStatus(event.orderId, event.userId, status);

        if (response.error != null) {
          emit(PreparingError(error: response.error!));
        } else {
          emit(PreparingSuccess());
        }
      }

      if (event is CancelOrderEvent) {
        emit(CancellingOrder());
        var status = "Cancelling";
        var response =
            await api.changeOrderStatus(event.orderId, event.userId, status);

        if (response.error != null) {
          emit(CancellingError(error: response.error!));
        } else {
          emit(CancellingSuccess());
        }
      }
    });
  }
}
