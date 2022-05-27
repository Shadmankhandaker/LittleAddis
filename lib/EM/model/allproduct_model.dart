class AllProductModel {
  String? responseCode;
  String? msg;
  List<Products>? products;
  String? status;

  AllProductModel({this.responseCode, this.msg, this.products, this.status});

  AllProductModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = msg;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
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
  String? whole_sale;
  String? stock;

  Products(
      {this.product_id,
      this.product_name,
      this.product_description,
      this.product_features,
      this.product_add_desc,
      this.product_price,
      this.product_sale_price,
      this.product_create_date,
      this.product_image,
      this.whole_sale,
      this.stock});

  Products.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['a_product_name'];
    product_description = json['a_product_description'];
    product_features = json['a_product_description'];
    product_add_desc = json['a_product_add_desc'];
    product_price = json['product_price'];
    product_sale_price = json['product_sale_price'];
    product_create_date = json['product_create_date'];
    product_image = json['product_image'];
    whole_sale = json['whole_sale'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = product_id;
    data['a_product_name'] = product_name;
    data['a_product_description'] = product_description;
    data['a_product_description'] = product_features;
    data['a_product_add_desc'] = product_add_desc;
    data['product_price'] = product_price;
    data['product_sale_price'] = product_sale_price;
    data['product_create_date'] = product_create_date;
    data['product_image'] = product_image;
    data['whole_sale'] = whole_sale;
    data['stock'] = stock;
    return data;
  }
}
