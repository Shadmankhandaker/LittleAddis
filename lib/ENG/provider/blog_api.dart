import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/blog_model.dart';

class BlogApi {
  Future<BlogModel> blogApi() async {
    try {
      var responseJson;
      await http.post(Uri.parse('${baseUrl()}/get_all_blogs')).then((response) {
        responseJson = _returnResponse(response);
      }).catchError((onError) {
        print(onError);
      });
      return BlogModel.fromJson(responseJson);
    } catch (e) {
      return BlogModel();
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

final blogApi = BlogApi();
