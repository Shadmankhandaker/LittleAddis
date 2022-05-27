import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:love/EM/model/v2/products_response/all_products_response_model.dart';
import 'package:love/global.dart';
import 'package:love/EM/model/allproduct_model.dart';
import 'package:love/woocommerce/woocommerce_api.dart';

class AllProductApi {

  Future<List<AllProductsResponseModel>> productApi() async {

    WooCommerceAPI wooCommerceAPI = new WooCommerceAPI(
        url: '${baseUrl2()}',
        consumerKey: "${consumerKey()}",
        consumerSecret: "${consumerSecret()}");

    List responseJson = [];

    responseJson = await wooCommerceAPI.getAsync("products");

    return responseJson.map((m) => AllProductsResponseModel.fromJson(m)).toList();

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
final allproductApi = AllProductApi();
