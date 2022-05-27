import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/signup_model.dart';
import 'package:love/models/signup/sign_up_body.dart';
import 'package:love/models/signup/sign_up_response_model.dart';
import 'package:love/woocommerce/woocommerce_api.dart';

class SignupApi {
  Future<SignUpModel> signupApi(String username, String email, String type,
      String phone, String password) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}register');
    Map<String, String> headers = {
      "Accesstoken": "access_token",
      "Content-Type": "application/json"
    };
    var request = http.MultipartRequest('POST', uri)
      ..fields['username'] = username
      ..fields['email'] = email
      ..fields['type'] = type
      ..fields['phone'] = phone
      ..fields['password'] = password;

    // var response = await request.send();
    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    return SignUpModel.fromJson(responseJson);

    // var responseJson;
    // await http.post('${baseUrl()}/register', body: {
    //   'email': email,
    //   'password': password,
    //   'username': username,
    //   'profile_pic': image,
    // }).then((response) {
    //   responseJson = _returnResponse(response);
    // }).catchError((onError) {
    //   print(onError);
    // });
    // return SignUpModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<SignUpResponseModel> signUpApiNew(SignUpBody body) async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: '${baseUrl2()}',
        consumerKey: "${consumerKey()}",
        consumerSecret: "${consumerSecret()}");

    try {
      var responseJson = await wooCommerceAPI
          .postAsync('customers', body.toJson())
          .catchError((onError) => print(onError));
      return SignUpResponseModel.fromJson(responseJson);
    } catch (e) {
      print(e.toString());
      return SignUpResponseModel();
    }
  }
}
