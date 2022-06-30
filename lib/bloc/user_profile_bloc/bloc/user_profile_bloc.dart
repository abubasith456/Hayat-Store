import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/models/user_profile_model.dart';

import '../../../api/api_provider.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    final _provider = ApiProvider();
    on<UserProfileEvent>((event, emit) async {
      if (event is GetUserDataEvent) {
        emit(UserProfileLoadingState());
        var _userProfileList = await _provider.getUserProfile(event.userId);
        if (_userProfileList.error != null) {
          emit(UserProfileError(_userProfileList.error.toString()));
        } else
          emit(UserProfileLoadedSate(_userProfileList));
      }
    });
  }
}
