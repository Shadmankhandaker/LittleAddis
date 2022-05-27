class GetAddressModal {
  String? responseCode;
  String? name;
  List<Products> products = [];
  String? message;
  String? status;

  GetAddressModal(
      {this.responseCode,
      this.name,
      this.products = const [],
      this.message,
      this.status});

  GetAddressModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    name = json['name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['name'] = name;
    if (products != null) {
      data['products'] = products.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Products {
  String? userId;
  String? userName;
  String? userMobile;
  String? addressPin;
  String? addressState;
  String? addressTown;
  String? addressCity;
  String? addressType;
  String? addressOpenSat;
  String? addressOpenSun;

  Products(
      {this.userId,
      this.userName,
      this.userMobile,
      this.addressPin,
      this.addressState,
      this.addressTown,
      this.addressCity,
      this.addressType,
      this.addressOpenSat,
      this.addressOpenSun});

  Products.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    addressPin = json['address_pin'];
    addressState = json['address_state'];
    addressTown = json['address_town'];
    addressCity = json['address_city'];
    addressType = json['address_type'];
    addressOpenSat = json['address_open_sat'];
    addressOpenSun = json['address_open_sun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_mobile'] = userMobile;
    data['address_pin'] = addressPin;
    data['address_state'] = addressState;
    data['address_town'] = addressTown;
    data['address_city'] = addressCity;
    data['address_type'] = addressType;
    data['address_open_sat'] = addressOpenSat;
    data['address_open_sun'] = addressOpenSun;
    return data;
  }
}
