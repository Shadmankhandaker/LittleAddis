class PaymentResponseModel {
  int? success;
  String? message;

  PaymentResponseModel({this.success, this.message});

  PaymentResponseModel.fromJson(dynamic json) {
    success = json["success"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["message"] = message;
    return map;
  }
}
