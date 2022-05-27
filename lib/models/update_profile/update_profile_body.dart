class UpdateProfileBody {
  String? firstName;
  String? lastName;
  String? email;
  Billing? billing;

  UpdateProfileBody({this.firstName, this.lastName, this.email, this.billing});

  UpdateProfileBody.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    billing =
        json["billing"] != null ? Billing.fromJson(json["billing"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    if (billing != null) {
      map["billing"] = billing!.toJson();
    }
    return map;
  }
}

class Billing {
  String? phone;

  Billing({this.phone});

  Billing.fromJson(dynamic json) {
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["phone"] = phone;
    return map;
  }
}
