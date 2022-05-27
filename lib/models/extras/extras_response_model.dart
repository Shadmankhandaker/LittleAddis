/// code : "Int"
/// message : "String"

class ExtrasResponseModel {
  String? _code;
  String? _message;

  String get code => _code!;
  String get message => _message!;

  ExtrasResponseModel({String? code, String? message}) {
    _code = code;
    _message = message;
  }

  ExtrasResponseModel.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    return map;
  }
}
