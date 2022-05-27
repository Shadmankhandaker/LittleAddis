class ForgetPasswordBody {
  String? userLogin;

  ForgetPasswordBody({this.userLogin});

  ForgetPasswordBody.fromJson(dynamic json) {
    userLogin = json["user_login"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_login"] = userLogin;
    return map;
  }
}
