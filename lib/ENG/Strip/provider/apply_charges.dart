import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';

class ApplyCharges {
  Future applyCharges(String custID, BuildContext context, int charge) async {
    var responseJson;

    /* SharedPreferences preferences = await SharedPreferences.getInstance();
    final myString = preferences.getString('price') ?? '';
*/

    try {
      final response = await http.Client().post(
        Uri.parse("https://api.stripe.com/v1/charges"),
        body: {
          "amount": charge.toString(),
          "currency": "inr",
          // "currency": "gbp",
          "customer": custID,
          "description": "Testing"
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
          'Authorization': 'Bearer sk_test_6pLA6JU3fnwYPv8vlRGhnx8B'
        },
      );

      // 'Authorization': 'Bearer sk_test_3kDGQKUlgPyOfZjiGqsDXazp'

      print('Response ${response.body}');

      return responseJson = _returnResponse(response, context);
    } on Exception {
      throw Exception('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response, BuildContext context) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        payerrorDialog(
          context,
          "Missing required information being passed",
          button: true,
        );
        throw Exception(response.body.toString());
      case 404:
        payerrorDialog(
          context,
          "Resource not found",
          button: true,
        );
        throw Exception(response.body.toString());
      case 401:
        payerrorDialog(
          context,
          "Unable to authorize the user",
          button: true,
        );
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
      case 501:
      case 503:
      case 504:
        payerrorDialog(
          context,
          "Payment Gateway Error",
          button: true,
        );
        throw Exception(response.body.toString());
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

final applyCharges = ApplyCharges();
