import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/EM/model/updateCart_model.dart';
import 'package:love/global.dart';

class UpdateCartApi {
  Future<UpdateCartModel> updatecartApi(
      String cartId, String quantity, String userId, String productId) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/cart_qty_update'), body: {
      'cart_id': cartId,
      'quantity': quantity,
      'user_id': userId,
      'product_id': productId
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return UpdateCartModel.fromJson(responseJson);
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
