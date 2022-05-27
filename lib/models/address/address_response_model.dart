class AddressResponseModel {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  Billing? billing;
  Shipping? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;

  AddressResponseModel(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.email,
      this.firstName,
      this.lastName,
      this.role,
      this.username,
      this.billing,
      this.shipping,
      this.isPayingCustomer,
      this.avatarUrl});

  AddressResponseModel.fromJson(dynamic json) {
    id = json["id"];
    dateCreated = json["date_created"];
    dateCreatedGmt = json["date_created_gmt"];
    dateModified = json["date_modified"];
    dateModifiedGmt = json["date_modified_gmt"];
    email = json["email"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    role = json["role"];
    username = json["username"];
    billing =
        json["billing"] != null ? Billing.fromJson(json["billing"]) : null;
    shipping =
        json["shipping"] != null ? Shipping.fromJson(json["shipping"]) : null;
    isPayingCustomer = json["is_paying_customer"];
    avatarUrl = json["avatar_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["date_created"] = dateCreated;
    map["date_created_gmt"] = dateCreatedGmt;
    map["date_modified"] = dateModified;
    map["date_modified_gmt"] = dateModifiedGmt;
    map["email"] = email;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["role"] = role;
    map["username"] = username;
    if (billing != null) {
      map["billing"] = billing!.toJson();
    }
    if (shipping != null) {
      map["shipping"] = shipping!.toJson();
    }
    map["is_paying_customer"] = isPayingCustomer;
    map["avatar_url"] = avatarUrl;
    return map;
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Shipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  Shipping.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    company = json["company"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    city = json["city"];
    state = json["state"];
    postcode = json["postcode"];
    country = json["country"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["company"] = company;
    map["address_1"] = address1;
    map["address_2"] = address2;
    map["city"] = city;
    map["state"] = state;
    map["postcode"] = postcode;
    map["country"] = country;
    return map;
  }
}

class Billing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Billing(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  Billing.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    company = json["company"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    city = json["city"];
    state = json["state"];
    postcode = json["postcode"];
    country = json["country"];
    email = json["email"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["company"] = company;
    map["address_1"] = address1;
    map["address_2"] = address2;
    map["city"] = city;
    map["state"] = state;
    map["postcode"] = postcode;
    map["country"] = country;
    map["email"] = email;
    map["phone"] = phone;
    return map;
  }
}
