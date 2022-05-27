class ProfileModal {
  String? responseCode;
  String? message;
  User? user;
  String? status;

  ProfileModal({this.responseCode, this.message, this.user, this.status});

  ProfileModal.fromJson(Map<String, dynamic> json) {
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
  String? number;
  String? email;
  String? fname;
  String? gender;
  String? bdate;
  String? location;
  String? profile_pic;
  String? profile_created;

  User(
      {this.number,
      this.email,
      this.fname,
      this.gender,
      this.bdate,
      this.location,
      this.profile_pic,
      this.profile_created});

  User.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    email = json['email'];
    fname = json['fname'];
    gender = json['gender'];
    bdate = json['bdate'];
    location = json['location'];
    profile_pic = json['profile_pic'];
    profile_created = json['profile_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['email'] = email;
    data['fname'] = fname;
    data['gender'] = gender;
    data['bdate'] = bdate;
    data['location'] = location;
    data['profile_pic'] = profile_pic;
    data['profile_created'] = profile_created;
    return data;
  }
}
