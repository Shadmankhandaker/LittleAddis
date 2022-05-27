class PaymentBody {
  String? token;
  String? amount;
  String? orderId;

  PaymentBody({this.token, this.amount, this.orderId});

  PaymentBody.fromJson(dynamic json) {
    token = json["token"];
    amount = json["amount"];
    orderId = json["orderId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = token;
    map["amount"] = amount;
    map["orderId"] = orderId;
    return map;
  }
}
