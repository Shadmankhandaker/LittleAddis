class OrderPlaceResponseModel {
  int? id;
  int? parentId;
  String? number;
  String? orderKey;
  String? createdVia;
  String? version;
  String? status;
  String? currency;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  bool? pricesIncludeTax;
  int? customerId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? customerNote;
  Billing? billing;
  Shipping? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? datePaid;
  String? datePaidGmt;
  String? dateCompleted;
  String? dateCompletedGmt;
  String? cartHash;
  List<Meta_data>? metaData;
  List<Line_items>? lineItems;
  List<Tax_lines>? taxLines;
  List<Shipping_lines>? shippingLines;

  OrderPlaceResponseModel({
    this.id,
    this.parentId,
    this.number,
    this.orderKey,
    this.createdVia,
    this.version,
    this.status,
    this.currency,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.pricesIncludeTax,
    this.customerId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.dateCompleted,
    this.dateCompletedGmt,
    this.cartHash,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
  });

  OrderPlaceResponseModel.fromJson(dynamic json) {
    id = json["id"];
    parentId = json["parent_id"];
    number = json["number"];
    orderKey = json["order_key"];
    createdVia = json["created_via"];
    version = json["version"];
    status = json["status"];
    currency = json["currency"];
    dateCreated = json["date_created"];
    if (json["date_created_gmt"] != null) {
      dateCreatedGmt = json["date_created_gmt"];
    }
    if (json["date_modified"] != null) dateModified = json["date_modified"];
    if (json["date_modified_gmt"] != null) {
      dateModifiedGmt = json["date_modified_gmt"];
    }
    discountTotal = json["discount_total"];
    discountTax = json["discount_tax"];
    shippingTotal = json["shipping_total"];
    shippingTax = json["shipping_tax"];
    cartTax = json["cart_tax"];
    total = json["total"];
    totalTax = json["total_tax"];
    pricesIncludeTax = json["prices_include_tax"];
    customerId = json["customer_id"];
    customerIpAddress = json["customer_ip_address"];
    customerUserAgent = json["customer_user_agent"];
    customerNote = json["customer_note"];
    billing =
        json["billing"] != null ? Billing.fromJson(json["billing"]) : null;
    shipping =
        json["shipping"] != null ? Shipping.fromJson(json["shipping"]) : null;
    paymentMethod = json["payment_method"];
    paymentMethodTitle = json["payment_method_title"];
    transactionId = json["transaction_id"];
    datePaid = json["date_paid"];
    datePaidGmt = json["date_paid_gmt"];
    dateCompleted = json["date_completed"];
    dateCompletedGmt = json["date_completed_gmt"];
    cartHash = json["cart_hash"];
    if (json["meta_data"] != null) {
      metaData = [];
      json["meta_data"].forEach((v) {
        metaData!.add(Meta_data.fromJson(v));
      });
    }
    if (json["line_items"] != null) {
      lineItems = [];
      json["line_items"].forEach((v) {
        lineItems!.add(Line_items.fromJson(v));
      });
    }
    if (json["tax_lines"] != null) {
      taxLines = [];
      json["tax_lines"].forEach((v) {
        taxLines!.add(Tax_lines.fromJson(v));
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
    map["id"] = id;
    map["parent_id"] = parentId;
    map["number"] = number;
    map["order_key"] = orderKey;
    map["created_via"] = createdVia;
    map["version"] = version;
    map["status"] = status;
    map["currency"] = currency;
    map["date_created"] = dateCreated;
    map["date_created_gmt"] = dateCreatedGmt;
    map["date_modified"] = dateModified;
    map["date_modified_gmt"] = dateModifiedGmt;
    map["discount_total"] = discountTotal;
    map["discount_tax"] = discountTax;
    map["shipping_total"] = shippingTotal;
    map["shipping_tax"] = shippingTax;
    map["cart_tax"] = cartTax;
    map["total"] = total;
    map["total_tax"] = totalTax;
    map["prices_include_tax"] = pricesIncludeTax;
    map["customer_id"] = customerId;
    map["customer_ip_address"] = customerIpAddress;
    map["customer_user_agent"] = customerUserAgent;
    map["customer_note"] = customerNote;
    if (billing != null) {
      map["billing"] = billing!.toJson();
    }
    if (shipping != null) {
      map["shipping"] = shipping!.toJson();
    }
    map["payment_method"] = paymentMethod;
    map["payment_method_title"] = paymentMethodTitle;
    map["transaction_id"] = transactionId;
    map["date_paid"] = datePaid;
    map["date_paid_gmt"] = datePaidGmt;
    map["date_completed"] = dateCompleted;
    map["date_completed_gmt"] = dateCompletedGmt;
    map["cart_hash"] = cartHash;
    if (metaData != null) {
      map["meta_data"] = metaData!.map((v) => v.toJson()).toList();
    }
    if (lineItems != null) {
      map["line_items"] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (taxLines != null) {
      map["tax_lines"] = taxLines!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      map["shipping_lines"] = shippingLines!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  Collection.fromJson(dynamic json) {
    href = json["href"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["href"] = href;
    return map;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(dynamic json) {
    href = json["href"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["href"] = href;
    return map;
  }
}

class Shipping_lines {
  int? id;
  String? methodTitle;
  String? methodId;
  String? total;
  String? totalTax;
  List<dynamic>? taxes;
  List<dynamic>? metaData;

  Shipping_lines(
      {this.id,
      this.methodTitle,
      this.methodId,
      this.total,
      this.totalTax,
      this.taxes,
      this.metaData});

  Shipping_lines.fromJson(dynamic json) {
    id = json["id"];
    methodTitle = json["method_title"];
    methodId = json["method_id"];
    total = json["total"];
    totalTax = json["total_tax"];
    if (json["taxes"] != null) {
      taxes = json["taxes"];
    }
    if (json["meta_data"] != null) {
      metaData = json["meta_data"];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["method_title"] = methodTitle;
    map["method_id"] = methodId;
    map["total"] = total;
    map["total_tax"] = totalTax;
    map["taxes"] = taxes!.map((v) => v.toJson()).toList();
    map["meta_data"] = metaData!.map((v) => v.toJson()).toList();
    return map;
  }
}

class Tax_lines {
  int? id;
  String? rateCode;
  int? rateId;
  String? label;
  bool? compound;
  String? taxTotal;
  String? shippingTaxTotal;
  List<dynamic>? metaData;

  Tax_lines(
      {this.id,
      this.rateCode,
      this.rateId,
      this.label,
      this.compound,
      this.taxTotal,
      this.shippingTaxTotal,
      this.metaData});

  Tax_lines.fromJson(dynamic json) {
    id = json["id"];
    rateCode = json["rate_code"];
    rateId = json["rate_id"];
    label = json["label"];
    compound = json["compound"];
    taxTotal = json["tax_total"];
    shippingTaxTotal = json["shipping_tax_total"];
    if (json["meta_data"] != null) {
      metaData = json["meta_data"];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["rate_code"] = rateCode;
    map["rate_id"] = rateId;
    map["label"] = label;
    map["compound"] = compound;
    map["tax_total"] = taxTotal;
    map["shipping_tax_total"] = shippingTaxTotal;
    map["meta_data"] = metaData!.map((v) => v.toJson()).toList();
    return map;
  }
}

class Line_items {
  int? id;
  String? name;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  String? sku;
  String? price;

  Line_items(
      {this.id,
      this.name,
      this.productId,
      this.variationId,
      this.quantity,
      this.taxClass,
      this.subtotal,
      this.subtotalTax,
      this.total,
      this.totalTax,
      this.sku,
      this.price});

  Line_items.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    productId = json["product_id"];
    variationId = json["variation_id"];
    quantity = json["quantity"];
    taxClass = json["tax_class"];
    subtotal = json["subtotal"];
    subtotalTax = json["subtotal_tax"];
    total = json["total"];
    totalTax = json["total_tax"];
    sku = json["sku"];

    if (json["price"] is int || json["price"] is double) {
      price = json["price"].toString();
    } else {
      price = json["price"];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["product_id"] = productId;
    map["variation_id"] = variationId;
    map["quantity"] = quantity;
    map["tax_class"] = taxClass;
    map["subtotal"] = subtotal;
    map["subtotal_tax"] = subtotalTax;
    map["total"] = total;
    map["total_tax"] = totalTax;
    map["sku"] = sku;
    map["price"] = price;
    return map;
  }
}

class Taxes {
  int? id;
  String? total;
  String? subtotal;

  Taxes({this.id, this.total, this.subtotal});

  Taxes.fromJson(dynamic json) {
    id = json["id"];
    total = json["total"];
    subtotal = json["subtotal"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["total"] = total;
    map["subtotal"] = subtotal;
    return map;
  }
}

class Meta_data {
  int? id;
  String? key;
  String? value;

  Meta_data({this.id, this.key, this.value});

  Meta_data.fromJson(dynamic json) {
    id = json["id"];
    key = json["key"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["key"] = key;
    map["value"] = value;
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
