import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'like_product_state.dart';

class LikeProductCubit extends Cubit<bool> {
  LikeProductCubit() : super(false);

  void likeProduct() => emit(true);
  void disLikeProduct() => emit(false);
}
