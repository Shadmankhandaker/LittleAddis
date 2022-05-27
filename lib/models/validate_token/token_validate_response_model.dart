/// success : true
/// statusCode : 200
/// message : "Token is valid"

class TokenValidateResponseModel {
  bool? _success;
  int? _statusCode;
  String? _message;

  bool get success => _success!;
  int get statusCode => _statusCode!;
  String get message => _message!;

  TokenValidateResponseModel(
      {bool? success, int? statusCode, String? message}) {
    _success = success;
    _statusCode = statusCode;
    _message = message;
  }

  TokenValidateResponseModel.fromJson(dynamic json) {
    _success = json["success"];
    _statusCode = json["statusCode"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["statusCode"] = _statusCode;
    map["message"] = _message;
    return map;
  }
}
