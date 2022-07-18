import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/db/userDB.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpEvent>((event, emit) async {
      if (event is OtpEndEvent) {
        emit(OtpEndState());
      }
      if (event is OtpVerifyButtonPressedEvent) {
        emit(OtpVerificationLoadingState());
        var user = await UserDb.instance.readAllUser();
        String email = user[1].email;
        print(email);
        //Do api work
      }
    });
  }
}
