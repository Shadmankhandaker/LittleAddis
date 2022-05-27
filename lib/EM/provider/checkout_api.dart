import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/EM/model/checkout_modal.dart';
import 'package:love/EM/model/deletecart_modal.dart';
import 'package:love/EM/model/profile_modal.dart';
import 'package:love/models/payment_stripe/payment_body.dart';
import 'package:love/models/payment_stripe/payment_response_model.dart';
import 'package:love/models/payment_stripe/payment_response_model.dart';
import 'package:love/models/payment_stripe/payment_response_model.dart';
import 'package:love/models/payment_stripe/payment_response_model.dart';

class CheckoutApi {
  Future<CheckoutModel> checkoutApi(
      String userId, String total, String paymentMode, String address) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/checkout'), body: {
      'user_id': userId,
      "total": total,
      "payment_mode": paymentMode,
      "address": address
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return CheckoutModel.fromJson(responseJson);
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
