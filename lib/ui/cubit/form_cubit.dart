
import 'package:bloc/bloc.dart';
import 'package:my_app/models/form_data.dart';
import 'package:my_app/models/post.dart';
import 'package:my_app/services/data_service.dart';




class FormCubit extends Cubit<FormState> {
  FormCubit(this._dataService) : super(const FormStateInitial());
  final DataService _dataService;
  Future<void> postData(FormModel form) async{
    try {
      emit(const FormStateLoading());
    final posts = await _dataService.postData(form);
    emit(FormStateLoaded(posts));
    } catch(e) {
      emit(const FormStateError('Not connected to the internet'));
      rethrow;
    }
  }
}






abstract class FormState {
  const FormState();
}

class FormStateInitial extends FormState {
const FormStateInitial();
}

class FormStateLoading extends FormState {
const FormStateLoading();
}

class FormStateLoaded extends FormState {
   FormStateLoaded(this.posts);
  final List<Post> posts;

}

class FormStateError extends FormState {
  
  const FormStateError(this.message);
final String message;
}
