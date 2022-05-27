import 'package:love/ENG/repository/repository.dart';
import 'package:love/models/signup/sign_up_response_model.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc {
  final _signupBlocController = PublishSubject<SignUpResponseModel>();

  Stream<SignUpResponseModel> get signupStream => _signupBlocController.stream;

  Future<SignUpResponseModel> signupSink(String firstName, String lastName,
      String email, String type, String phone, String password) async {
    return await Repository()
        .signupRepository(firstName, lastName, email, type, phone, password);
  }

  dispose() {
    _signupBlocController.close();
  }
}

final signupBloc = SignupBloc();
