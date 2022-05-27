import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:love/global.dart';
import 'package:love/EM/model/newAddress_model.dart';
import 'package:love/EM/model/signup_model.dart';


class AddressApi {
  Future<AddressModel> addressApi(
      String user_id,String user_name, String user_mobile, String address_pin,String address_state,
      String address_town,String address_city,String address_type,String address_open_sat,String address_open_sun) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}/add_new_address');
    var request = https.MultipartRequest('POST', uri)
      ..fields['user_id'] = user_id
      ..fields['user_name'] = user_name
      ..fields['user_mobile'] = user_mobile
      ..fields['address_pin'] = address_pin
      ..fields['address_state'] = address_state
      ..fields['address_town'] = address_town
      ..fields['address_city'] = address_city
      ..fields['address_type'] = address_type
      ..fields['address_open_sat'] = address_open_sat
      ..fields['address_open_sun'] = address_open_sun;


    // var response = await request.send();
    https.Response response =
    await https.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    return AddressModel.fromJson(responseJson);

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

  dynamic _returnResponse(https.Response response) {
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
