class PlaceOrderBody {
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  Billing? billing;
  Shipping? shipping;
  List<Line_items>? lineItems;
  List<Shipping_lines>? shippingLines;

  PlaceOrderBody(
      {this.paymentMethod,
      this.paymentMethodTitle,
      this.setPaid,
      this.billing,
      this.shipping,
      this.lineItems,
      this.shippingLines});

  PlaceOrderBody.fromJson(dynamic json) {
    paymentMethod = json["payment_method"];
    paymentMethodTitle = json["payment_method_title"];
    setPaid = json["set_paid"];
    billing =
        json["billing"] != null ? Billing.fromJson(json["billing"]) : null;
    shipping =
        json["shipping"] != null ? Shipping.fromJson(json["shipping"]) : null;
    if (json["line_items"] != null) {
      lineItems = [];
      json["line_items"].forEach((v) {
        lineItems!.add(Line_items.fromJson(v));
      });
    }
    if (json["shipping_lines"] != null) {
      shippingLines = [];
      json["shipping_lines"].forEach((v) {
        shippingLines!.add(Shipping_lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["payment_method"] = paymentMethod;
    map["payment_method_title"] = paymentMethodTitle;
    map["set_paid"] = setPaid;
    if (billing != null) {
      map["billing"] = billing!.toJson();
    }
    if (shipping != null) {
      map["shipping"] = shipping!.toJson();
    }
    if (lineItems != null) {
      map["line_items"] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      map["shipping_lines"] = shippingLines!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Shipping_lines {
  String? methodId;
  String? methodTitle;
  String? total;

  Shipping_lines({this.methodId, this.methodTitle, this.total});

  Shipping_lines.fromJson(dynamic json) {
    methodId = json["method_id"];
    methodTitle = json["method_title"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["method_id"] = methodId;
    map["method_title"] = methodTitle;
    map["total"] = total;
    return map;
  }
}

class Line_items {
  int? productId;
  int? quantity;
  String? grandTotal;

  Line_items({this.productId, this.quantity, this.grandTotal});

  Line_items.fromJson(dynamic json) {
    productId = json["product_id"];
    quantity = json["quantity"];
    grandTotal = json["grandTotal"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product_id"] = productId;
    map["quantity"] = quantity;
    map["grandTotal"] = grandTotal;
    return map;
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Shipping(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  Shipping.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
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
