class CartResponseModel {
  String? code;
  String? message;
  Data? data;
  String? key;
  int? productId;
  int? variationId;
  int? quantity;
  String? dataHash;
  int? lineSubtotal;
  int? lineSubtotalTax;
  int? lineTotal;
  int? lineTax;
  String? productName;
  String? productTitle;
  String? productPrice;

  CartResponseModel(
      {this.code,
      this.message,
      this.data,
      this.key,
      this.productId,
      this.variationId,
      this.quantity,
      this.dataHash,
      this.lineSubtotal,
      this.lineSubtotalTax,
      this.lineTotal,
      this.lineTax,
      this.productName,
      this.productTitle,
      this.productPrice});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) code = json['code'];
    if (json['message'] != null) message = json['message'];
    if (json['data'] != null)
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['key'] != null) key = json['key'];
    if (json['product_id'] != null) productId = json['product_id'];
    if (json['variation_id'] != null) variationId = json['variation_id'];
    if (json['quantity'] != null) quantity = json['quantity'];
    if (json['data_hash'] != null) dataHash = json['data_hash'];
    if (json['line_subtotal'] != null) lineSubtotal = json['line_subtotal'];
    if (json['line_subtotal_tax'] != null)
      lineSubtotalTax = json['line_subtotal_tax'];
    if (json['line_total'] != null) lineTotal = json['line_total'];
    if (json['lineTax'] != null) lineTax = json['line_tax'];
    if (json['product_name'] != null) productName = json['product_name'];
    if (json['product_title'] != null) productTitle = json['product_title'];
    if (json['product_price'] != null) productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['key'] = key;
    data['product_id'] = productId;
    data['variation_id'] = variationId;
    data['quantity'] = quantity;
    data['data_hash'] = dataHash;
    data['line_subtotal'] = lineSubtotal;
    data['line_subtotal_tax'] = lineSubtotalTax;
    data['line_total'] = lineTotal;
    data['line_tax'] = lineTax;
    data['product_name'] = productName;
    data['product_title'] = productTitle;
    data['product_price'] = productPrice;
    return data;
  }
}

class Data {
  Data();

  Data.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
