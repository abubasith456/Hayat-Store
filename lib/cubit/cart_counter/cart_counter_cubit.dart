import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_counter_state.dart';

class CartCounterCubit extends Cubit<double> {
  CartCounterCubit() : super(0);
  void increment() => emit(state + 0.5);
  void decrement() => emit(state - 0.5);
}
