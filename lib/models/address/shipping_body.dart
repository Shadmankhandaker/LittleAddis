class ShippingBody {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  ShippingBody(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  ShippingBody.fromJson(dynamic json) {
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
