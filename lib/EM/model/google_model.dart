class GoogleModel {
  String? responseCode;
  String? message;
  User? user;
  String? status;

  GoogleModel({this.responseCode, this.message, this.user, this.status});

  GoogleModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class User {
  String? id;
  String? fname;
  String? number;
  String? userType;
  String? loginType;
  String? email;
  String? password;
  String? gender;
  String? bdate;
  String? location;
  String? profilePic;
  String? date;
  String? role;

  User(
      {this.id,
      this.fname,
      this.number,
      this.userType,
      this.loginType,
      this.email,
      this.password,
      this.gender,
      this.bdate,
      this.location,
      this.profilePic,
      this.date,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    number = json['number'];
    userType = json['user_type'];
    loginType = json['login_type'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    bdate = json['bdate'];
    location = json['location'];
    profilePic = json['profile_pic'];
    date = json['date'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fname'] = fname;
    data['number'] = number;
    data['user_type'] = userType;
    data['login_type'] = loginType;
    data['email'] = email;
    data['password'] = password;
    data['gender'] = gender;
    data['bdate'] = bdate;
    data['location'] = location;
    data['profile_pic'] = profilePic;
    data['date'] = date;
    data['role'] = role;
    return data;
  }
}
