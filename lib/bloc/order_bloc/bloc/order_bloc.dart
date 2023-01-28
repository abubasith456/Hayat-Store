import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
// import 'package:shop_app/models/cart_requesr_model.dart';
import 'package:shop_app/models/my_db_model.dart';
import 'package:shop_app/models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    var api = new ApiProvider();

    on<OrderEvent>((event, emit) async {
      if (event is PlaceTheOrder) {
        emit(OrderLoadingState());
        List<Products> prodductList = List.generate(
            event.listOfProducts.length,
            (index) => Products(
                  productId: event.listOfProducts[index].productId,
                  productImage: event.listOfProducts[index].productImage,
                  productName: event.listOfProducts[index].name,
                  quantity: event.listOfProducts[index].quantity,
                ));

        List product = [];
        prodductList.forEach((element) {
          print(element.toJson());
          product.add(element.toJson());
        });

        OrdersNewModel ordersNewModel = OrdersNewModel(
            uniqueId: event.userId,
            numOfItems: event.listOfProducts.length,
            userId: event.userId,
            userName: event.name,
            products: prodductList,
            amount: event.totalAmount,
            status: "Preparing",
            address: "Chennai");

        var response = await api.postOrders(ordersNewModel.toJson());


        if (response.error != null) {
          emit(OrderErrorState());
        } else {
          emit(OrderPlaced(orderdItemModel: response));
        }
      }
    });
  }
}
