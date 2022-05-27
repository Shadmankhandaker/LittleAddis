/// username : "androidtesting3@gmail.com"
/// password : "123456"

class LoginBody {
  String? _username;
  String? _password;

  String get username => _username!;
  String get password => _password!;

  LoginBody({String? username, String? password}) {
    _username = username;
    _password = password;
  }

  LoginBody.fromJson(dynamic json) {
    _username = json["username"];
    _password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }
}
