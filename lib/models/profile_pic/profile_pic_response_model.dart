class ProfilePicResponseModel {
  int? success;
  String? message;
  String? body;

  ProfilePicResponseModel({this.success, this.message, this.body});

  ProfilePicResponseModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    body = json["body"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["message"] = message;
    map["body"] = body;
    return map;
  }
}
