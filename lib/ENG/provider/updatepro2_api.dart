import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/updateprofile2_model.dart';


class UpdateproApi2 {
  Future<UpdateproModel2> updateproApi(
      String number,
      String fname,
      String gender,
      String email,
      String bdate,
      String location,
      String user_id ) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}/update_profile');
    var request = http.MultipartRequest('POST', uri)
      ..fields['number'] = number
      ..fields['fname'] = fname
      ..fields['gender'] = gender
      ..fields['email'] = email
      ..fields['bdate'] = bdate
      ..fields['location'] = location
      ..fields['user_id'] = user_id;
  

    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    return UpdateproModel2.fromJson(responseJson);

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
