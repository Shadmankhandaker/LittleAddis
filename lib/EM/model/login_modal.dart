class LoginModel {
  String? responseCode;
  String? message;
  String? status;
  String? userId;
  String? userRole;
  String? userToken;

  LoginModel(
      {this.responseCode,
      this.message,
      this.status,
      this.userId,
      this.userRole,
      this.userToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    userId = json['user_id'];
    userRole = json['user_role'];
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    data['status'] = status;
    data['user_id'] = userId;
    data['user_role'] = userRole;
    data['user_token'] = userToken;
    return data;
  }
}
