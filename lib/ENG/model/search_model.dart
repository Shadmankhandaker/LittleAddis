class SearchModal {
  String? responseCode;
  String? message;
  List<SearchProducts>? products;
  String? status;

  SearchModal({this.responseCode, this.message, this.products, this.status});

  SearchModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['products'] != null) {
      products = <SearchProducts>[];
      json['products'].forEach((v) {
        products?.add(SearchProducts.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class SearchProducts {
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

  SearchProducts(
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

  SearchProducts.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['product_name'];
    product_description = json['product_description'];
    product_features = json['product_features'];
    product_add_desc = json['product_add_desc'];
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
    data['product_name'] = product_name;
    data['product_description'] = product_description;
    data['product_features'] = product_features;
    data['product_add_desc'] = product_add_desc;
    data['product_price'] = product_price;
    data['product_sale_price'] = product_sale_price;
    data['product_create_date'] = product_create_date;
    data['product_image'] = product_image;
    data['whole_sale'] = whole_sale;
    data['stock'] = stock;
    return data;
  }
}
