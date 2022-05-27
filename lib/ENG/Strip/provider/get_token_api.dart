import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';

class GetCardToken {
  Future getCardToken(String cardNumber, String month, String year,
      String cvcNumber, String cardHolderName, BuildContext context) async {
    var responseJson;
    try {
      final response = await http.Client()
          .post(Uri.parse("https://api.stripe.com/v1/tokens"), body: {
        "card[number]": cardNumber,
        "card[exp_month]": month,
        "card[exp_year]": year,
        "card[cvc]": cvcNumber,
        "card[name]": cardHolderName
      }, headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'Authorization': 'Bearer pk_test_DyE8LNvYX1ZHzr0TNkk1srRy'
      });

      // 'Authorization': 'Bearer pk_test_DSbu0LSIgMMy183n70PnVGk4'

      return responseJson = _returnResponse(response, context);
    } on Exception {
      payerrorDialog(
        context,
        "Something went wrong.",
        button: true,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomeEng()),
      );
    }
  }

  // sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62
  // sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62
// sk_live_lCtPjoinQO39U0PntCc9jqFB00OwzbUi5C
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

final getCardToken = GetCardToken();
