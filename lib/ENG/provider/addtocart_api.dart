import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/addtocart_model.dart';
import 'package:love/ENG/model/signup_model.dart';


class AddtocartApi {
  Future<AddtocartModel> addtocartApi(
      String user_id,String product_id, String quantity) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}/add_to_cart');
    var request = http.MultipartRequest('POST', uri)
      ..fields['user_id'] = user_id
      ..fields['product_id'] = product_id
      ..fields['quantity'] = quantity;


    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    return AddtocartModel.fromJson(responseJson);


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
}
