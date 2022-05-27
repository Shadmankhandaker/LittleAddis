import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/EM/model/v2/products_response/all_products_response_model.dart';
import 'package:love/global.dart';
import 'package:love/ENG/model/search_model.dart';
import 'package:love/woocommerce/woocommerce_api.dart';

class SearchApi {
  Future<SearchModal> searchApi(String name) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/product_search'), body: {
      'name': name,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return SearchModal.fromJson(responseJson);
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

  Future<List<AllProductsResponseModel>> searchProduct(String search) async {
    List responseJson = [];

    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: baseUrl2() ?? "",
        consumerKey: consumerKey() ?? "",
        consumerSecret: consumerSecret() ?? "");

    await wooCommerceAPI.getAsync("products/?search=$search").then((value) {
      responseJson = value;
    }).catchError((onError) {
      print('Exception $onError');
    });

    return responseJson
        .map((m) => AllProductsResponseModel.fromJson(m))
        .toList();
  }
}
