class CartDataResponseModel {
  String? currency;
  String? cartKey;
  String? cartHash;
  List<Items>? items;
  int? itemCount;
  bool? needsShipping;
  bool? needsPayment;
  Totals? totals;

  CartDataResponseModel(
      {this.currency,
      this.cartKey,
      this.cartHash,
      this.items,
      this.itemCount,
      this.needsShipping,
      this.needsPayment,
      this.totals});

  CartDataResponseModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    cartKey = json['cart_key'];
    cartHash = json['cart_hash'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    itemCount = json['item_count'];
    needsShipping = json['needs_shipping'];
    needsPayment = json['needs_payment'];
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['cart_key'] = cartKey;
    data['cart_hash'] = cartHash;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['item_count'] = itemCount;
    data['needs_shipping'] = needsShipping;
    data['needs_payment'] = needsPayment;
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    return data;
  }
}

class Items {
  String? key;
  int? productId;
  String? dataHash;
  String? productName;
  String? productTitle;
  String? productPrice;
  String? slug;
  String? productType;
  bool? tags;
  String? sku;
  String? priceRaw;
  String? price;
  String? linePrice;
  StockStatus? stockStatus;
  int? minPurchaseQuantity;
  int? maxPurchaseQuantity;
  bool? virtual;
  bool? downloadable;
  String? permalink;
  int? quantity;

  Items(
      {this.key,
      this.productId,
      this.dataHash,
      this.productName,
      this.productTitle,
      this.productPrice,
      this.slug,
      this.productType,
      this.tags,
      this.sku,
      this.priceRaw,
      this.price,
      this.linePrice,
      this.stockStatus,
      this.minPurchaseQuantity,
      this.maxPurchaseQuantity,
      this.virtual,
      this.downloadable,
      this.permalink,
      this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    productId = json['product_id'];
    dataHash = json['data_hash'];
    productName = json['product_name'];
    productTitle = json['product_title'];
    if (json['product_price'] is double) {
      productPrice = json['product_price'].toString();
    } else {
      productPrice = json['product_price'];
    }
    slug = json['slug'];
    productType = json['product_type'];
    tags = json['tags'];
    sku = json['sku'];
    if (json['price_raw'] is double) {
      priceRaw = json['price_raw'].toString();
    } else {
      priceRaw = json['price_raw'];
    }
    price = json['price'];
    linePrice = json['line_price'];
    stockStatus = json['stock_status'] != null
        ? StockStatus.fromJson(json['stock_status'])
        : null;
    minPurchaseQuantity = json['min_purchase_quantity'];
    maxPurchaseQuantity = json['max_purchase_quantity'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    permalink = json['permalink'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['product_id'] = productId;
    data['data_hash'] = dataHash;
    data['product_name'] = productName;
    data['product_title'] = productTitle;
    data['product_price'] = productPrice;
    data['slug'] = slug;
    data['product_type'] = productType;
    data['tags'] = tags;
    data['sku'] = sku;
    data['price_raw'] = priceRaw;
    data['price'] = price;
    data['line_price'] = linePrice;
    data['stock_status'] = stockStatus!.toJson();
    data['min_purchase_quantity'] = minPurchaseQuantity;
    data['max_purchase_quantity'] = maxPurchaseQuantity;
    data['virtual'] = virtual;
    data['downloadable'] = downloadable;
    data['permalink'] = permalink;
    data['quantity'] = quantity;
    return data;
  }
}

class StockStatus {
  String? status;
  int stockQuantity=0;
  String? hexColor;

  StockStatus({this.status, this.stockQuantity=0, this.hexColor});

  StockStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    stockQuantity = json['stock_quantity'];
    hexColor = json['hex_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['stock_quantity'] = stockQuantity;
    data['hex_color'] = hexColor;
    return data;
  }
}

class Totals {
  String? subtotal;
  String? subtotalTax;
  String? shippingTotal;
  String? shippingTax;
  String? discountTotal;
  String? discountTax;
  String? cartContentsTotal;
  String? cartContentsTax;
  String? feeTotal;
  String? feeTax;
  String? total;
  String? totalTax;

  Totals(
      {this.subtotal,
      this.subtotalTax,
      this.shippingTotal,
      this.shippingTax,
      this.discountTotal,
      this.discountTax,
      this.cartContentsTotal,
      this.cartContentsTax,
      this.feeTotal,
      this.feeTax,
      this.total,
      this.totalTax});

  Totals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    cartContentsTotal = json['cart_contents_total'];
    cartContentsTax = json['cart_contents_tax'];
    feeTotal = json['fee_total'];
    feeTax = json['fee_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['subtotal_tax'] = subtotalTax;
    data['shipping_total'] = shippingTotal;
    data['shipping_tax'] = shippingTax;
    data['discount_total'] = discountTotal;
    data['discount_tax'] = discountTax;
    data['cart_contents_total'] = cartContentsTotal;
    data['cart_contents_tax'] = cartContentsTax;
    data['fee_total'] = feeTotal;
    data['fee_tax'] = feeTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    return data;
  }
}
