/// email : "androidtesting1@gmail.com"
/// first_name : "Android"
/// last_name : "Testing"
/// password : "123456"
/// username : "androidtesting"
/// meta_data : [{"key":"mobile_number","value":"1234567890"}]

class SignUpBody {
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _password;
  String? _username;
  List<Meta_data>? _metaData;

  String get email => _email!;
  String get firstName => _firstName!;
  String get lastName => _lastName!;
  String get password => _password!;
  String get username => _username!;
  List<Meta_data> get metaData => _metaData!;

  SignUpBody(
      {String? email,
      String? firstName,
      String? lastName,
      String? password,
      String? username,
      List<Meta_data>? metaData}) {
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _password = password;
    _username = username;
    _metaData = metaData;
  }

  SignUpBody.fromJson(dynamic json) {
    _email = json["email"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _password = json["password"];
    _username = json["username"];
    if (json["meta_data"] != null) {
      _metaData = [];
      json["meta_data"].forEach((v) {
        _metaData!.add(Meta_data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["password"] = _password;
    map["username"] = _username;
    if (_metaData != null) {
      map["meta_data"] = _metaData!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// key : "mobile_number"
/// value : "1234567890"

class Meta_data {
  String? _key;
  String? _value;

  String get key => _key!;
  String get value => _value!;

  Meta_data({String? key, String? value}) {
    _key = key;
    _value = value;
  }

  Meta_data.fromJson(dynamic json) {
    _key = json["key"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = _key;
    map["value"] = _value;
    return map;
  }
}
