import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/EM/model/cartproduct_model.dart';
import 'package:love/models/cart/add_to_cart_body.dart';
import 'package:love/models/cart/cart_response_model.dart';
import 'package:love/models/cart/cartdata_response_model.dart';

class CartProductApi {
  Future<CartProductModel> cartApi(String userID) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/get_cart_items'), body: {
      'user_id': userID,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return CartProductModel.fromJson(responseJson);
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

  Future<CartResponseModel> addToCartApi(
      AddToCartBody body, String token) async {
    var responseJson;
    try {
      await http
          .post(Uri.parse('${baseUrl2()}/wp-json/cocart/v1/add-item'),
              headers: {'Authorization': 'Bearer $token'}, body: body.toJson())
          .then((value) => responseJson = _returnResponse(value))
          .catchError((onError) => print(onError));
      return CartResponseModel.fromJson(responseJson);
    } catch (e) {
      print(e.toString());
      return CartResponseModel.fromJson(responseJson);
    }
  }

  Future<CartDataResponseModel> getCartData(String token) async {
    var responseJson;

    try {
      await http
          .get(Uri.parse('${baseUrl2()}/wp-json/cocart/v1/get-cart'),
              headers: {'Authorization': 'Bearer $token'})
          .then((value) => responseJson = json.decode(value.body))
          .catchError((onError) => print(onError));
      return CartDataResponseModel.fromJson(responseJson);
    } catch (e) {
      print(e.toString());
      return CartDataResponseModel.fromJson(responseJson);
    }
  }

  Future<bool> deleteCart(String cartKey, String token) async {
    bool responseJson = false;

    try {
      final url = Uri.parse('${baseUrl2()}/wp-json/cocart/v1/item');
      final request = http.Request('DELETE', url);
      request.headers
          .addAll(<String, String>{'Authorization': 'Bearer $token'});
      request.body = jsonEncode({'cart_item_key': cartKey});
      await request
          .send()
          .then((value) => responseJson = _returnResponseCartDelete(value))
          .catchError((onError) => print(onError));
      return responseJson;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  bool _returnResponseCartDelete(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        return true;
      case 400:
        return false;
      case 401:
        return false;
      case 403:
        return false;
      case 500:
        return false;
      default:
        return false;
    }
  }

  Future<String> cartCount(String token) async {
    var responseJson;

    try {
      await http
          .get(Uri.parse('${baseUrl2()}/wp-json/cocart/v1/count-items'),
              headers: {'Authorization': 'Bearer $token'})
          .then((value) => responseJson = _returnResponse(value))
          .catchError((onError) => print(onError));

      return responseJson.toString();
    } catch (e) {
      print(e.toString());
      return "0";
    }
  }
}

final cartproductApi = CartProductApi();
