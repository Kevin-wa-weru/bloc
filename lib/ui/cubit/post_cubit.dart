
import 'package:bloc/bloc.dart';
import 'package:my_app/models/post.dart';
import 'package:my_app/services/data_service.dart';




class MyAppCubit extends Cubit<MyAppState> {
  MyAppCubit(this._dataService) : super(const MyAppStateInitial());
  final DataService _dataService;
  Future<void> getData() async{
    try {
      emit(const MyAppStateLoading());
    final posts = await _dataService.getPosts();
    emit(MyAppStateLoaded(posts));
    } catch(e) {
      emit(const MyAppStateError('Not connected to the internet'));
      rethrow;
    }
  }
}






abstract class MyAppState {
  const MyAppState();
}

class MyAppStateInitial extends MyAppState {
const MyAppStateInitial();
}

class MyAppStateLoading extends MyAppState {
const MyAppStateLoading();
}

class MyAppStateLoaded extends MyAppState {
   MyAppStateLoaded(this.posts);
  final List<Post> posts;

}

class MyAppStateError extends MyAppState {
  
  const MyAppStateError(this.message);
final String message;
}
