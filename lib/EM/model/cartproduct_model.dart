class CartProductModel {
  String? responseCode;
  String? msg;
  List<Cart1>? cart;
  int? cart_total;
  int? cart_stripe_total;
  int? total_items;
  String? status;

  CartProductModel(
      {this.responseCode,
      this.msg,
      this.cart,
      this.cart_total,
      this.cart_stripe_total,
      this.total_items,
      this.status});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['message'];
    if (json['cart'] != null) {
      cart = <Cart1>[];
      json['cart'].forEach((v) {
        cart?.add(Cart1.fromJson(v));
      });
    }
    cart_total = json['cart_total'];
    cart_stripe_total = json['cart_stripe_total'];
    total_items = json['total_items'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = msg;
    if (cart != null) {
      data['cart'] = cart?.map((v) => v.toJson()).toList();
    }
    data['cart_total'] = cart_total;
    data['cart_stripe_total'] = cart_stripe_total;
    data['total_items'] = total_items;
    data['status'] = status;
    return data;
  }
}

class Cart1 {
  String? product_id;
  String? cart_id;
  String? product_image;
  String? product_name;
  String? quantity;
  String? price;

  Cart1({
    this.product_id,
    this.cart_id,
    this.product_image,
    this.product_name,
    this.quantity,
    this.price,
  });

  Cart1.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    cart_id = json['cart_id'];
    product_image = json['product_image'];
    product_name = json['a_product_name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = product_id;
    data['cart_id'] = cart_id;
    data['product_image'] = product_image;
    data['a_product_name'] = product_name;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
