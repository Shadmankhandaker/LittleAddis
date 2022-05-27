/// success : false
/// statusCode : 403
/// code : "invalid_username"
/// message : "Unknown username. Check again or try your email address."
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc3RhZ2luZy5saXR0bGVhZGRpcy5jb20iLCJpYXQiOjE2MTU5NTk1MDEsIm5iZiI6MTYxNTk1OTUwMSwiZXhwIjoxNjE2NTY0MzAxLCJkYXRhIjp7InVzZXIiOnsiaWQiOjE3NX19fQ.1U06MFYGExtrO3YOGbNuImIpoioBFS9V6A91b1RT8f8","id":175,"email":"androidtesting3@gmail.com","nicename":"android-testing","firstName":"Android Testing","lastName":"Android Testing","displayName":"Android Testing"}

class LoginResponseModel {
  bool? _success;
  int? _statusCode;
  String? _code;
  String? _message;
  Data? _data;
  List<Data>? _data2;

  bool get success => _success ?? false;
  int get statusCode => _statusCode ?? 0;
  String get code => _code ?? "";
  String get message => _message ?? "";
  Data get data => _data ?? Data();
  List<Data> get data2 => _data2 ?? [];

  LoginResponseModel(
      {bool? success,
      int? statusCode,
      String? code,
      String? message,
      Data? data}) {
    _success = success;
    _statusCode = statusCode;
    _code = code;
    _message = message;
    _data = data;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _success = json["success"];
    _statusCode = json["statusCode"];
    _code = json["code"];
    _message = json["message"];
    if (_success == true) {
      _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    } else {
      _data2 = [];
      json["data"].forEach((v) {
        _data2!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["statusCode"] = _statusCode;
    map["code"] = _code;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data!.toJson();
    }
    return map;
  }
}

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc3RhZ2luZy5saXR0bGVhZGRpcy5jb20iLCJpYXQiOjE2MTU5NTk1MDEsIm5iZiI6MTYxNTk1OTUwMSwiZXhwIjoxNjE2NTY0MzAxLCJkYXRhIjp7InVzZXIiOnsiaWQiOjE3NX19fQ.1U06MFYGExtrO3YOGbNuImIpoioBFS9V6A91b1RT8f8"
/// id : 175
/// email : "androidtesting3@gmail.com"
/// nicename : "android-testing"
/// firstName : "Android Testing"
/// lastName : "Android Testing"
/// displayName : "Android Testing"

class Data {
  String? _token;
  int? _id;
  String? _email;
  String? _nicename;
  String? _firstName;
  String? _lastName;
  String? _displayName;

  String? get token => _token;
  int? get id => _id;
  String? get email => _email;
  String? get nicename => _nicename;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get displayName => _displayName;

  Data(
      {String? token,
      int? id,
      String? email,
      String? nicename,
      String? firstName,
      String? lastName,
      String? displayName}) {
    _token = token;
    _id = id;
    _email = email;
    _nicename = nicename;
    _firstName = firstName;
    _lastName = lastName;
    _displayName = displayName;
  }

  Data.fromJson(dynamic json) {
    _token = json["token"];
    _id = json["id"];
    _email = json["email"];
    _nicename = json["nicename"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _displayName = json["displayName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = _token;
    map["id"] = _id;
    map["email"] = _email;
    map["nicename"] = _nicename;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["displayName"] = _displayName;
    return map;
  }
}
