import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/EM/model/deletecart_modal.dart';
import 'package:love/EM/model/profile_modal.dart';

class DeleteCartApi {
  Future<DeleteCartModel> deletecartApi(String cartId) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/remove_cart_item'), body: {
      'cart_id': cartId,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return DeleteCartModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);

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
