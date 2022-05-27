class ForgetPasswordResponseModel {
  String? _code;
  String? _message;
  Data? _data;

  ForgetPasswordResponseModel({String? code, String? message, Data? data}) {
    _code = code;
    _message = message;
    _data = data;
  }

  String get code => _code!;
  set code(String code) => _code = code;
  String get message => _message!;
  set message(String message) => _message = message;
  Data get data => _data!;
  set data(Data data) => _data = data;

  ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] is int) {
      code = json['code'].toString();
    } else {
      code = json['code'];
    }
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['message'] = _message;
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  int? _status;

  Data({int? status}) {
    _status = status;
  }

  int get status => _status!;
  set status(int status) => _status = status;

  Data.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    return data;
  }
}
