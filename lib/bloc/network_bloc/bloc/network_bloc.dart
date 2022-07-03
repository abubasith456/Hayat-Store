import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late StreamSubscription<ConnectivityResult> _subscription;
  late Connectivity connectivity = Connectivity();
  var _connectionStatus = 'Unknown';
  NetworkBloc() : super(NetworkInitial()) {
    on<NetworkEvent>((event, emit) async {
      if (event is ListenConnection) {
        _subscription = connectivity.onConnectivityChanged
            .listen((ConnectivityResult result) {
          add(ConnectionChanged(result));
          _connectionStatus = result.toString();
          print(_connectionStatus);
        });
      }
      if (event is ConnectionChanged) {
        if (event.connection == ConnectivityResult.none) {
          emit(ConnectionFailure());
        } else if (event.connection == ConnectivityResult.mobile ||
            event.connection == ConnectivityResult.wifi) {
          emit(ConnectionSuccess());
        }
      }
    });
  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
