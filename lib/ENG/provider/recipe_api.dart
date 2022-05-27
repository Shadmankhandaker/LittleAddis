import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/recipe_response_model.dart';

class RecipeApi {
  Future<RecipeResponseModel> recipeApi() async {
    var responseJson;
    try {
      await http
          .get(Uri.parse('https://thelovegrass.com/wp-json/wl/v1/wp_recipe'))
          .then((response) {
        responseJson = _returnResponse(response);
      }).catchError((onError) {
        print(onError);
      });
      return RecipeResponseModel.fromJson(responseJson);
    } catch (e) {
      return RecipeResponseModel();
    }
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

final recipeApi = RecipeApi();
