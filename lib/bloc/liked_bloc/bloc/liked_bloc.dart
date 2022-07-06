import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/db/LikedProductDB.dart';
import 'package:shop_app/models/likedDB_model.dart';

part 'liked_event.dart';
part 'liked_state.dart';

class LikedBloc extends Bloc<LikedEvent, LikedState> {
  LikedBloc() : super(LikedInitial()) {
    on<LikedEvent>((event, emit) async {
      if (event is GetLikedDBEvent) {
        try {
          emit(LoadingLikedState());
          var _likedDBList = await LikedDatabase.instance.readAllcart();
          if (_likedDBList.isEmpty) {
            emit(ErrorLikedState("You're not liked any products!..."));
          } else {
            emit(LoadedLikedState(_likedDBList));
          }
        } catch (e) {
          emit(ErrorLikedState(e.toString()));
        }
      }

      if (event is LikeProductEvent) {
        await LikedDatabase.instance.create(event.likedModel);
        print("Product Liked");
      } else if (event is DisLikeProductEvent) {
        await LikedDatabase.instance.delete(event.likedModel.productId as int);
        print("Product Disliked and deleted");
      }
    });
  }
}
