import 'package:love/EM/repository/repository.dart';
import 'package:love/models/login/login_response_model.dart';
import 'package:love/models/validate_token/token_validate_response_model.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _loginBlocController = PublishSubject<LoginResponseModel>();
  final _tokenValidateController = PublishSubject<TokenValidateResponseModel>();

  Stream<LoginResponseModel> get loginStream => _loginBlocController.stream;
  Stream<TokenValidateResponseModel> get tokenStream =>
      _tokenValidateController.stream;

  Future<LoginResponseModel> loginSink(String email, String password) async {
    return await Repository().loginApiRepository(email, password);
  }

  Future<TokenValidateResponseModel> tokenSink(
      String token, String email, String password) async {
    return await Repository().tokenValidate(token, email, password);
  }

  dispose() {
    _loginBlocController.close();
    _tokenValidateController.close();
  }
}

final loginBloc = LoginBloc();
