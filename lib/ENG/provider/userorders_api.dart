import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/allproduct_model.dart';
import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/woocommerce/woocommerce_api.dart';

class UserOrdersApi {
  Future<UserOrdersModel> userordersApi(String userID) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/get_user_orders'), body: {
      'user_id': userID,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return UserOrdersModel.fromJson(responseJson);
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

  Future<List<OrdersResponseModel>> getOrders() async {
    List responseJson = [];

    WooCommerceAPI api = WooCommerceAPI(
        url: '${baseUrl2()}',
        consumerKey: "${consumerKey()}",
        consumerSecret: "${consumerSecret()}");

    await api.getAsync('orders').then((value) {
      responseJson = value;
    }).catchError((onError) {
      print(onError);
      return null;
    });

    return responseJson.map((e) => OrdersResponseModel.fromJson(e)).toList();
  }
}

final userordersApi = UserOrdersApi();
