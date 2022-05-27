import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/checkout_modal.dart';
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

  Future<PaymentResponseModel> makePayment(Map<String, String> dataMap) async {
    var responseJson;

    await http
        .post(Uri.parse('${baseUrl2()}/api/createPayemnt.php'),
            body: dataMap, encoding: Encoding.getByName("utf-8"))
        .then((value) => responseJson = _returnResponse(value))
        .catchError((onError) {
      print('Exception $onError');
      return null;
    });

    print("Response $responseJson");

    if (responseJson == null) {
      return PaymentResponseModel();
    } else {
      return PaymentResponseModel.fromJson(responseJson);
    }
  }
}
