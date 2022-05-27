/// cart_item_key : "9cea886b9f44a3c2df1163730ab64994"

class CartItemKeyModel {
  String? _cartItemKey;

  String get cartItemKey => _cartItemKey!;

  CartItemKeyModel({String? cartItemKey}) {
    _cartItemKey = cartItemKey!;
  }

  CartItemKeyModel.fromJson(dynamic json) {
    _cartItemKey = json["cart_item_key"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cart_item_key"] = _cartItemKey;
    return map;
  }
}
