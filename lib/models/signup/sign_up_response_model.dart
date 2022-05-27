/// id : 172
/// date_created : "2021-03-16T10:20:57"
/// date_created_gmt : "2021-03-16T10:20:57"
/// date_modified : "2021-03-16T10:20:58"
/// date_modified_gmt : "2021-03-16T10:20:58"
/// email : "androidtesting1@gmail.com"
/// first_name : "Android"
/// last_name : "Testing"
/// role : "customer"
/// username : "androidtesting"
/// billing : {"first_name":"","last_name":"","company":"","address_1":"","address_2":"","city":"","postcode":"","country":"","state":"","email":"","phone":""}
/// shipping : {"first_name":"","last_name":"","company":"","address_1":"","address_2":"","city":"","postcode":"","country":"","state":""}
/// is_paying_customer : false
/// avatar_url : "http://1.gravatar.com/avatar/dbd96b9251607eb75bc9e282bfb85b94?s=96&d=mm&r=g"
/// meta_data : [{"id":5295,"key":"hubwoo_pro_user_data_change","value":"yes"},{"id":5297,"key":"mobile_number","value":"1234567890"}]

class SignUpResponseModel {
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  String? _dateModified;
  String? _dateModifiedGmt;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _role;
  String? _username;
  Billing? _billing;
  Shipping? _shipping;
  bool? _isPayingCustomer;
  String? _avatarUrl;
  List<Meta_data>? _metaData;
  String? _code;
  String? _message;

  int get id => _id ?? 0;
  String get dateCreated => _dateCreated ?? "";
  String get dateCreatedGmt => _dateCreatedGmt ?? "";
  String get dateModified => _dateModified ?? "";
  String get dateModifiedGmt => _dateModifiedGmt ?? "";
  String get email => _email ?? "";
  String get firstName => _firstName ?? "";
  String get lastName => _lastName ?? "";
  String get role => _role ?? "";
  String get username => _username ?? "";
  String get code => _code ?? "";
  String get message => _message ?? "";
  Billing get billing => _billing ?? Billing();
  Shipping get shipping => _shipping ?? Shipping();
  bool get isPayingCustomer => _isPayingCustomer ?? false;
  String get avatarUrl => _avatarUrl ?? "";
  List<Meta_data> get metaData => _metaData ?? [];

  SignUpResponseModel(
      {int? id,
      String? dateCreated,
      String? dateCreatedGmt,
      String? dateModified,
      String? dateModifiedGmt,
      String? email,
      String? firstName,
      String? lastName,
      String? role,
      String? username,
      Billing? billing,
      Shipping? shipping,
      bool? isPayingCustomer,
      String? avatarUrl,
      List<Meta_data>? metaData}) {
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _role = role;
    _username = username;
    _billing = billing;
    _shipping = shipping;
    _isPayingCustomer = isPayingCustomer;
    _avatarUrl = avatarUrl;
    _metaData = metaData;
  }

  SignUpResponseModel.fromJson(dynamic json) {
    _id = json["id"];
    _dateCreated = json["date_created"];
    _dateCreatedGmt = json["date_created_gmt"];
    _dateModified = json["date_modified"];
    _dateModifiedGmt = json["date_modified_gmt"];
    _email = json["email"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _role = json["role"];
    _username = json["username"];
    _billing =
        json["billing"] != null ? Billing.fromJson(json["billing"]) : null;
    _shipping =
        json["shipping"] != null ? Shipping.fromJson(json["shipping"]) : null;
    _isPayingCustomer = json["is_paying_customer"];
    _avatarUrl = json["avatar_url"];
    if (json["meta_data"] != null) {
      _metaData = [];
      json["meta_data"].forEach((v) {
        _metaData!.add(Meta_data.fromJson(v));
      });
    }
    if (json['code'] != null) {
      _code = json['code'];
    }
    if (json['message'] != null) {
      _message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["date_created"] = _dateCreated;
    map["date_created_gmt"] = _dateCreatedGmt;
    map["date_modified"] = _dateModified;
    map["date_modified_gmt"] = _dateModifiedGmt;
    map["email"] = _email;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["role"] = _role;
    map["username"] = _username;
    if (_billing != null) {
      map["billing"] = _billing!.toJson();
    }
    if (_shipping != null) {
      map["shipping"] = _shipping!.toJson();
    }
    map['code'] = _code;
    map['message'] = _message;
    map["is_paying_customer"] = _isPayingCustomer;
    map["avatar_url"] = _avatarUrl;
    if (_metaData != null) {
      map["meta_data"] = _metaData!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 5295
/// key : "hubwoo_pro_user_data_change"
/// value : "yes"

class Meta_data {
  int? _id;
  String? _key;
  String? _value;

  int get id => _id!;
  String get key => _key!;
  String get value => _value!;

  Meta_data({int? id, String? key, String? value}) {
    _id = id;
    _key = key;
    _value = value;
  }

  Meta_data.fromJson(dynamic json) {
    _id = json["id"];
    _key = json["key"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["key"] = _key;
    map["value"] = _value;
    return map;
  }
}

/// first_name : ""
/// last_name : ""
/// company : ""
/// address_1 : ""
/// address_2 : ""
/// city : ""
/// postcode : ""
/// country : ""
/// state : ""

class Shipping {
  String? _firstName;
  String? _lastName;
  String? _company;
  String? _address1;
  String? _address2;
  String? _city;
  String? _postcode;
  String? _country;
  String? _state;

  String get firstName => _firstName!;
  String get lastName => _lastName!;
  String get company => _company!;
  String get address1 => _address1!;
  String get address2 => _address2!;
  String get city => _city!;
  String get postcode => _postcode!;
  String get country => _country!;
  String get state => _state!;

  Shipping(
      {String? firstName,
      String? lastName,
      String? company,
      String? address1,
      String? address2,
      String? city,
      String? postcode,
      String? country,
      String? state}) {
    _firstName = firstName;
    _lastName = lastName;
    _company = company;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _postcode = postcode;
    _country = country;
    _state = state;
  }

  Shipping.fromJson(dynamic json) {
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _company = json["company"];
    _address1 = json["address_1"];
    _address2 = json["address_2"];
    _city = json["city"];
    _postcode = json["postcode"];
    _country = json["country"];
    _state = json["state"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["company"] = _company;
    map["address_1"] = _address1;
    map["address_2"] = _address2;
    map["city"] = _city;
    map["postcode"] = _postcode;
    map["country"] = _country;
    map["state"] = _state;
    return map;
  }
}

/// first_name : ""
/// last_name : ""
/// company : ""
/// address_1 : ""
/// address_2 : ""
/// city : ""
/// postcode : ""
/// country : ""
/// state : ""
/// email : ""
/// phone : ""

class Billing {
  String? _firstName;
  String? _lastName;
  String? _company;
  String? _address1;
  String? _address2;
  String? _city;
  String? _postcode;
  String? _country;
  String? _state;
  String? _email;
  String? _phone;

  String get firstName => _firstName!;
  String get lastName => _lastName!;
  String get company => _company!;
  String get address1 => _address1!;
  String get address2 => _address2!;
  String get city => _city!;
  String get postcode => _postcode!;
  String get country => _country!;
  String get state => _state!;
  String get email => _email!;
  String get phone => _phone!;

  Billing(
      {String? firstName,
      String? lastName,
      String? company,
      String? address1,
      String? address2,
      String? city,
      String? postcode,
      String? country,
      String? state,
      String? email,
      String? phone}) {
    _firstName = firstName;
    _lastName = lastName;
    _company = company;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _postcode = postcode;
    _country = country;
    _state = state;
    _email = email;
    _phone = phone;
  }

  Billing.fromJson(dynamic json) {
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _company = json["company"];
    _address1 = json["address_1"];
    _address2 = json["address_2"];
    _city = json["city"];
    _postcode = json["postcode"];
    _country = json["country"];
    _state = json["state"];
    _email = json["email"];
    _phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["company"] = _company;
    map["address_1"] = _address1;
    map["address_2"] = _address2;
    map["city"] = _city;
    map["postcode"] = _postcode;
    map["country"] = _country;
    map["state"] = _state;
    map["email"] = _email;
    map["phone"] = _phone;
    return map;
  }
}
