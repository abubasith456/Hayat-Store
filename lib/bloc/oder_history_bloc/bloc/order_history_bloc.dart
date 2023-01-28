import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/orderHistoryModel.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    var api = new ApiProvider();
    List<OrderHistoryModel> list;
    on<OrderHistoryEvent>((event, emit) async {
      if (event is FetchHistoryList) {
        String userId = sl<SharedPrefService>().getData(userIdKey).toString();
        var response = await api.getOrders(userId);

        if (response.isEmpty) {
          emit(FetchOrderHistoryFailure());
        } else {
          List<OrderHistoryModel> responselist =
              response.map((e) => OrderHistoryModel.fromJson(e)).toList();
          emit(FetchOrderHistorySuccess(response: responselist));
        }
      }
    });
  }
}
