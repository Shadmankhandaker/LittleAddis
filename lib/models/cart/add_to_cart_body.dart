/// product_id : "8395"
/// quantity : 1

class AddToCartBody {
  String? _productId;
  int? _quantity;

  String get productId => _productId!;
  int get quantity => _quantity!;

  AddToCartBody({String? productId, int? quantity}) {
    _productId = productId!;
    _quantity = quantity!;
  }

  AddToCartBody.fromJson(dynamic json) {
    _productId = json["product_id"];
    _quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product_id"] = _productId;
    map["quantity"] = _quantity;
    return map;
  }
}
