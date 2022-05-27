import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../global.dart';

class CreateCutomer {
  Future createCutomer(String token, String email, BuildContext context) async {
    var responseJson;
    try {
      final response = await http.Client()
          .post(Uri.parse("https://api.stripe.com/v1/customers"), body: {
        "description": email,
        "source": token,
      }, headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'Authorization': 'Bearer sk_test_6pLA6JU3fnwYPv8vlRGhnx8B'
      });

      print(response.body);
      return responseJson = _returnResponse(response, context);

      // 'Authorization': 'Bearer sk_test_3kDGQKUlgPyOfZjiGqsDXazp'

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

final createCutomer = CreateCutomer();
