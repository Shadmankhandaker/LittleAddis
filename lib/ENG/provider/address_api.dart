import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:love/global.dart';
import 'package:love/ENG/model/newAddress_model.dart';
import 'package:love/ENG/model/signup_model.dart';
import 'package:love/models/address/address_response_model.dart';
import 'package:love/models/address/billing_body.dart';
import 'package:love/models/address/shipping_body.dart';
import 'package:love/woocommerce/woocommerce_api.dart';

class AddressApi {
  Future<AddressModel> addressApi(
      String userId,
      String userName,
      String userMobile,
      String addressPin,
      String addressState,
      String addressTown,
      String addressCity,
      String addressType,
      String addressOpenSat,
      String addressOpenSun) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}/add_new_address');
    var request = https.MultipartRequest('POST', uri)
      ..fields['user_id'] = userId
      ..fields['user_name'] = userName
      ..fields['user_mobile'] = userMobile
      ..fields['address_pin'] = addressPin
      ..fields['address_state'] = addressState
      ..fields['address_town'] = addressTown
      ..fields['address_city'] = addressCity
      ..fields['address_type'] = addressType
      ..fields['address_open_sat'] = addressOpenSat
      ..fields['address_open_sun'] = addressOpenSun;

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

  Future<AddressResponseModel> putAddress(
      String userId, BillingBody billingBody, ShippingBody shippingBody) async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: '${baseUrl2()}',
        consumerKey: "${consumerKey()}",
        consumerSecret: "${consumerSecret()}");

    Map<String, dynamic> result = {};
    result["billing"] = billingBody;
    result["shipping"] = shippingBody;

    var responseJson =
        await wooCommerceAPI.putAsync("customers/$userId/", result);

    return AddressResponseModel.fromJson(responseJson);
  }

  Future<AddressResponseModel> getAddress(int userId) async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: '${baseUrl2()}',
          consumerKey: "${consumerKey()}",
          consumerSecret: "${consumerSecret()}");

      var responseJson = await wooCommerceAPI.getAsync("customers/$userId/");

      return AddressResponseModel.fromJson(responseJson);
    } catch (e) {
      return AddressResponseModel();
    }
  }
}

final addressBloc = AddressApi();
