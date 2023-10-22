import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/news_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiProvider _apiProvider = ApiProvider();
  PostBloc() : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetPost) {
        print("GetPost called");
        emit(PostLoading());
        var postData = await _apiProvider.getPost();

        if (postData.error != null) {
          print("GetPost error" + postData.error!);
          emit(PostOnError(error: postData.error!));
        } else {
          print("GetPost success");
          emit(PostLoaded(newsModel: postData));
        }
      }
    });
  }
}
