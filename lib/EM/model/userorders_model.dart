class UserOrdersModel {
  String? responseCode;
  String? msg;
  List<Orders>? orders;
  String? status;

  UserOrdersModel({this.responseCode, this.msg, this.orders, this.status});

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['message'];

    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = msg;

    if (orders != null) {
      data['orders'] = orders?.map((v) => v.toJson()).toList();
    }

    data['status'] = status;
    return data;
  }
}

class Orders {
  String? order_id;
  String? total;
  String? date;
  String? payment_mode;
  String? address;
  String? txn_id;
  String? p_status;
  String? p_date;
  List<Products>? products;
  int? count;

  Orders({
    this.order_id,
    this.total,
    this.date,
    this.payment_mode,
    this.address,
    this.txn_id,
    this.p_status,
    this.p_date,
    this.products,
    this.count,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    order_id = json['order_id'];
    total = json['total'];
    date = json['date'];
    payment_mode = json['payment_mode'];
    address = json['address'];
    txn_id = json['txn_id'];
    p_status = json['p_status'];
    p_date = json['p_date'];

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = order_id;
    data['total'] = total;
    data['date'] = date;
    data['payment_mode'] = payment_mode;
    data['address'] = address;
    data['txn_id'] = txn_id;
    data['p_status'] = p_status;
    data['p_date'] = p_date;

    data['products'] = products?.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class Products {
  String? product_id;
  String? product_name;
  String? product_description;
  String? product_features;
  String? product_add_desc;
  String? product_price;
  String? product_sale_price;
  String? product_create_date;
  String? product_image;

  Products({
    this.product_id,
    this.product_name,
    this.product_description,
    this.product_features,
    this.product_add_desc,
    this.product_price,
    this.product_sale_price,
    this.product_create_date,
    this.product_image,
  });

  Products.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['a_product_name'];
    product_description = json['a_product_description'];
    product_features = json['a_product_features'];
    product_add_desc = json['a_product_add_desc'];
    product_price = json['product_price'];
    product_sale_price = json['product_sale_price'];
    product_create_date = json['product_create_date'];
    product_image = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = product_id;
    data['a_product_name'] = product_name;
    data['a_product_description'] = product_description;
    data['a_product_features'] = product_features;
    data['a_product_add_desc'] = product_add_desc;
    data['product_price'] = product_price;
    data['product_sale_price'] = product_sale_price;
    data['product_create_date'] = product_create_date;
    data['product_image'] = product_image;
    return data;
  }
}
