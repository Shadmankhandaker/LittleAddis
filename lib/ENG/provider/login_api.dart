import 'dart:convert';
import 'package:love/global.dart';
import 'package:love/ENG/block/handleResponse.dart';
import 'package:love/ENG/model/login_modal.dart';
import 'package:http/http.dart' as http;
import 'package:love/models/login/login_body.dart';
import 'package:love/models/login/login_response_model.dart';
import 'package:love/models/validate_token/token_validate_response_model.dart';

class LoginApi {
  Future<LoginModel> loginApi(String email, String password) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/login'), body: {
      'email': email,
      'password': password,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return LoginModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        handleResponse.handleResponseSink(true);
        return responseJson;
      case 400:
        handleResponse.handleResponseSink(false);
        throw Exception(response.body.toString());
      case 401:
        handleResponse.handleResponseSink(false);
        throw Exception(response.body.toString());
      case 403:
        handleResponse.handleResponseSink(false);
        throw Exception(response.body.toString());
      case 500:
      default:
        handleResponse.handleResponseSink(false);
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<LoginResponseModel> loginUser(LoginBody body) async {
    var responseJson;
    try {
      var responseJson = await http
          .post(
              Uri.parse(
                  'http://staging.littleaddis.com/wp-json/jwt-auth/v1/token'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode(body))
          .catchError((onError) => print(onError));
      return LoginResponseModel.fromJson(json.decode(responseJson.body));
    } catch (e) {
      print(e.toString());
      return LoginResponseModel();
    }
  }

  Future<TokenValidateResponseModel> tokenValidate(
      String token, String email, String password) async {
    var responseJson;
    try {
      await http
          .post(Uri.parse('${baseUrl2()}/wp-json/jwt-auth/v1/token'),
              headers: {'Authorization': 'Bearer $token'},
              body: {'username': email, 'password': password})
          .then((value) => responseJson = _returnResponse(value))
          .catchError((onError) => print(onError));
      return TokenValidateResponseModel.fromJson(responseJson);
    } catch (e) {
      print(e.toString());
      return TokenValidateResponseModel.fromJson(responseJson);
    }
  }
}
