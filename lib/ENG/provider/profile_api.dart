import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:love/global.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/models/orders/order_place_response_model.dart';
import 'package:love/models/profile_pic/profile_pic_response_model.dart';
import 'package:love/models/profile_response/profile_response_model.dart';
import 'package:love/models/update_profile/update_profile_body.dart'
    as UpdateProfile;
import 'package:love/woocommerce/woocommerce_api.dart';
import 'package:http_parser/http_parser.dart';

class ProfileApi {
  Future<ProfileModal> profileApi(String userID) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}/user_data'),
        body: {"user_id": userID}).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });

    return ProfileModal.fromJson(responseJson);
  }

  Future<ProfileResponseModel> getProfileInfo(String userId) async {
    ProfileResponseModel responseJson = ProfileResponseModel();

    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: '${baseUrl2()}',
        consumerKey: "${consumerKey()}",
        consumerSecret: "${consumerSecret()}");

    await wooCommerceAPI.getAsync('customers/$userId').then((value) {
      print("Getting Customer Data $value");
      responseJson = ProfileResponseModel.fromJson(value);
    }).catchError((onError) {
      print(onError);
      return null;
    });

    return responseJson;
  }

  Future<ProfileResponseModel> updateProfileInfo(String userId,
      String firstName, String lastName, String email, String phoneNumber,
      {String? url}) async {
    ProfileResponseModel responseJson = ProfileResponseModel();

    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: '${baseUrl2()}',
        consumerKey: "${consumerKey()}",
        consumerSecret: "${consumerSecret()}");

    UpdateProfile.Billing billing = UpdateProfile.Billing();
    billing.phone = phoneNumber;

    var map = {};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["billing"] = billing;

    print('url $url');

    if (url != null) {
      if (url.isNotEmpty) {
        List<Meta_data> data = [];
        Meta_data d = Meta_data();
        d.id = 1;
        d.key = "profile_picture";
        d.value = url;
        data.add(d);
        map["meta_data"] = data;
      }
    }

    await wooCommerceAPI.putAsync("customers/$userId", map).then((value) {
      print("Response $value");

      responseJson = ProfileResponseModel.fromJson(value);
    }).catchError((onError) {
      print(onError);
      return null;
    });

    return responseJson;
  }

  Future<ProfilePicResponseModel> uploadProfile(File image) async {
    ProfilePicResponseModel model = ProfilePicResponseModel();

    var request = http.MultipartRequest(
        "POST", Uri.parse("https://staging.littleaddis.com/api/do_upload.php"));

    request.files.add(await http.MultipartFile.fromPath(
      'fileToUpload',
      image.absolute.path,
      contentType: MediaType('application', 'x-tar'),
    ));

    http.StreamedResponse main = await request.send();

    var secondResponse = await http.Response.fromStream(main);

    if (secondResponse.statusCode == 200) {
      model =
          ProfilePicResponseModel.fromJson(json.decode(secondResponse.body));
    }

    return model;
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

  dynamic _returnResponse2(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        response.stream.transform(utf8.decoder).listen((value) {
          // return value;
        });
        break;
      case 400:
        throw Exception("Exception 400");
      case 401:
        throw Exception("Exception 401");
      case 403:
        throw Exception("Exception 403");
      case 500:
      default:
        throw Exception("Exception default");
    }
  }
}
