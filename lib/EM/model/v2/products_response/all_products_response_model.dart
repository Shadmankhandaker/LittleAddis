class AllProductsResponseModel {
  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  List<dynamic>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  int stockQuantity = 0;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Categories>? categories;
  List<dynamic>? tags;
  List<Images> images = [];
  List<Attributes>? attributes;
  List<dynamic>? defaultAttributes;
  List<dynamic>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  List<MetaData> metaData = [];
  String? stockStatus;
  Links? links;

  AllProductsResponseModel(
      {this.id,
      this.name,
      this.slug,
      this.permalink,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.type,
      this.status,
      this.featured,
      this.catalogVisibility,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleFromGmt,
      this.dateOnSaleTo,
      this.dateOnSaleToGmt,
      this.onSale,
      this.purchasable,
      this.totalSales,
      this.virtual,
      this.downloadable,
      this.downloads,
      this.downloadLimit,
      this.downloadExpiry,
      this.externalUrl,
      this.buttonText,
      this.taxStatus,
      this.taxClass,
      this.manageStock,
      this.stockQuantity = 0,
      this.backorders,
      this.backordersAllowed,
      this.backordered,
      this.soldIndividually,
      this.weight,
      this.dimensions,
      this.shippingRequired,
      this.shippingTaxable,
      this.shippingClass,
      this.shippingClassId,
      this.reviewsAllowed,
      this.averageRating,
      this.ratingCount,
      this.upsellIds,
      this.crossSellIds,
      this.parentId,
      this.purchaseNote,
      this.categories,
      this.tags,
      this.images = const [],
      this.attributes,
      this.defaultAttributes,
      this.variations,
      this.groupedProducts,
      this.menuOrder,
      this.priceHtml,
      this.relatedIds,
      this.metaData = const [],
      this.stockStatus,
      this.links});

  AllProductsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["permalink"] is String) {
      permalink = json["permalink"];
    }
    if (json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    if (json["date_created_gmt"] is String) {
      dateCreatedGmt = json["date_created_gmt"];
    }
    if (json["date_modified"] is String) {
      dateModified = json["date_modified"];
    }
    if (json["date_modified_gmt"] is String) {
      dateModifiedGmt = json["date_modified_gmt"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["featured"] is bool) {
      featured = json["featured"];
    }
    if (json["catalog_visibility"] is String) {
      catalogVisibility = json["catalog_visibility"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["short_description"] is String) {
      shortDescription = json["short_description"];
    }
    if (json["sku"] is String) {
      sku = json["sku"];
    }
    if (json["price"] is String) {
      price = json["price"];
    }
    if (json["regular_price"] is String) {
      regularPrice = json["regular_price"];
    }
    if (json["sale_price"] is String) {
      salePrice = json["sale_price"];
    }
    if (json["date_on_sale_from"] is dynamic) {
      dateOnSaleFrom = json["date_on_sale_from"];
    }
    if (json["date_on_sale_from_gmt"] is dynamic) {
      dateOnSaleFromGmt = json["date_on_sale_from_gmt"];
    }
    if (json["date_on_sale_to"] is dynamic) {
      dateOnSaleTo = json["date_on_sale_to"];
    }
    if (json["date_on_sale_to_gmt"] is dynamic) {
      dateOnSaleToGmt = json["date_on_sale_to_gmt"];
    }
    if (json["on_sale"] is bool) {
      onSale = json["on_sale"];
    }
    if (json["purchasable"] is bool) {
      purchasable = json["purchasable"];
    }
    if (json["total_sales"] is int) {
      totalSales = json["total_sales"];
    }
    if (json["virtual"] is bool) {
      virtual = json["virtual"];
    }
    if (json["downloadable"] is bool) {
      downloadable = json["downloadable"];
    }
    if (json["downloads"] is List) {
      downloads = json["downloads"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["download_limit"] is int) {
      downloadLimit = json["download_limit"];
    }
    if (json["download_expiry"] is int) {
      downloadExpiry = json["download_expiry"];
    }
    if (json["external_url"] is String) {
      externalUrl = json["external_url"];
    }
    if (json["button_text"] is String) {
      buttonText = json["button_text"];
    }
    if (json["tax_status"] is String) {
      taxStatus = json["tax_status"];
    }
    if (json["tax_class"] is String) {
      taxClass = json["tax_class"];
    }
    if (json["manage_stock"] is bool) {
      manageStock = json["manage_stock"];
    }
    if (json["stock_quantity"] is int) {
      stockQuantity = json["stock_quantity"];
    }
    if (json["backorders"] is String) {
      backorders = json["backorders"];
    }
    if (json["backorders_allowed"] is bool) {
      backordersAllowed = json["backorders_allowed"];
    }
    if (json["backordered"] is bool) {
      backordered = json["backordered"];
    }
    if (json["sold_individually"] is bool) {
      soldIndividually = json["sold_individually"];
    }
    if (json["weight"] is String) {
      weight = json["weight"];
    }
    if (json["dimensions"] is Map) {
      dimensions = json["dimensions"] == null
          ? null
          : Dimensions.fromJson(json["dimensions"]);
    }
    if (json["shipping_required"] is bool) {
      shippingRequired = json["shipping_required"];
    }
    if (json["shipping_taxable"] is bool) {
      shippingTaxable = json["shipping_taxable"];
    }
    if (json["shipping_class"] is String) {
      shippingClass = json["shipping_class"];
    }
    if (json["shipping_class_id"] is int) {
      shippingClassId = json["shipping_class_id"];
    }
    if (json["reviews_allowed"] is bool) {
      reviewsAllowed = json["reviews_allowed"];
    }
    if (json["average_rating"] is String) {
      averageRating = json["average_rating"];
    }
    if (json["rating_count"] is int) {
      ratingCount = json["rating_count"];
    }
    if (json["upsell_ids"] is List) {
      upsellIds = json["upsell_ids"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["cross_sell_ids"] is List) {
      crossSellIds = json["cross_sell_ids"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["parent_id"] is int) {
      parentId = json["parent_id"];
    }
    if (json["purchase_note"] is String) {
      purchaseNote = json["purchase_note"];
    }
    if (json["categories"] is List) {
      categories = json["categories"] == null
          ? []
          : (json["categories"] as List)
              .map((e) => Categories.fromJson(e))
              .toList();
    }
    if (json["tags"] is List) {
      tags = json["tags"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["images"] is List) {
      images = json["images"] == null
          ? []
          : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
    }
    if (json["attributes"] is List) {
      attributes = json["attributes"] == null
          ? []
          : (json["attributes"] as List)
              .map((e) => Attributes.fromJson(e))
              .toList();
    }
    if (json["default_attributes"] is List) {
      defaultAttributes =
          json["default_attributes"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["variations"] is List) {
      variations = json["variations"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["grouped_products"] is List) {
      groupedProducts = json["grouped_products"]?.cast<List<dynamic>>() ?? [];
    }
    if (json["menu_order"] is int) {
      menuOrder = json["menu_order"];
    }
    if (json["price_html"] is String) {
      priceHtml = json["price_html"];
    }
    if (json["meta_data"] is List) {
      metaData = json["meta_data"] == null
          ? []
          : (json["meta_data"] as List)
              .map((e) => MetaData.fromJson(e))
              .toList();
    }
    if (json["stock_status"] is String) {
      stockStatus = json["stock_status"];
    }
    if (json["_links"] is Map) {
      links = json["_links"] == null ? null : Links.fromJson(json["_links"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["slug"] = slug;
    data["permalink"] = permalink;
    data["date_created"] = dateCreated;
    data["date_created_gmt"] = dateCreatedGmt;
    data["date_modified"] = dateModified;
    data["date_modified_gmt"] = dateModifiedGmt;
    data["type"] = type;
    data["status"] = status;
    data["featured"] = featured;
    data["catalog_visibility"] = catalogVisibility;
    data["description"] = description;
    data["short_description"] = shortDescription;
    data["sku"] = sku;
    data["price"] = price;
    data["regular_price"] = regularPrice;
    data["sale_price"] = salePrice;
    data["date_on_sale_from"] = dateOnSaleFrom;
    data["date_on_sale_from_gmt"] = dateOnSaleFromGmt;
    data["date_on_sale_to"] = dateOnSaleTo;
    data["date_on_sale_to_gmt"] = dateOnSaleToGmt;
    data["on_sale"] = onSale;
    data["purchasable"] = purchasable;
    data["total_sales"] = totalSales;
    data["virtual"] = virtual;
    data["downloadable"] = downloadable;
    if (downloads != null) {
      data["downloads"] = downloads;
    }
    data["download_limit"] = downloadLimit;
    data["download_expiry"] = downloadExpiry;
    data["external_url"] = externalUrl;
    data["button_text"] = buttonText;
    data["tax_status"] = taxStatus;
    data["tax_class"] = taxClass;
    data["manage_stock"] = manageStock;
    data["stock_quantity"] = stockQuantity;
    data["backorders"] = backorders;
    data["backorders_allowed"] = backordersAllowed;
    data["backordered"] = backordered;
    data["sold_individually"] = soldIndividually;
    data["weight"] = weight;
    if (dimensions != null) {
      data["dimensions"] = dimensions?.toJson();
    }
    data["shipping_required"] = shippingRequired;
    data["shipping_taxable"] = shippingTaxable;
    data["shipping_class"] = shippingClass;
    data["shipping_class_id"] = shippingClassId;
    data["reviews_allowed"] = reviewsAllowed;
    data["average_rating"] = averageRating;
    data["rating_count"] = ratingCount;
    if (upsellIds != null) {
      data["upsell_ids"] = upsellIds;
    }
    if (crossSellIds != null) {
      data["cross_sell_ids"] = crossSellIds;
    }
    data["parent_id"] = parentId;
    data["purchase_note"] = purchaseNote;
    if (categories != null) {
      data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    if (tags != null) {
      data["tags"] = tags;
    }
    if (images != null) {
      data["images"] = images.map((e) => e.toJson()).toList();
    }
    if (attributes != null) {
      data["attributes"] = attributes;
    }
    if (defaultAttributes != null) {
      data["default_attributes"] = defaultAttributes;
    }
    if (variations != null) {
      data["variations"] = variations;
    }
    if (groupedProducts != null) {
      data["grouped_products"] = groupedProducts;
    }
    data["menu_order"] = menuOrder;
    data["price_html"] = priceHtml;
    if (metaData != null) {
      data["meta_data"] = metaData.map((e) => e.toJson()).toList();
    }
    data["stock_status"] = stockStatus;
    if (links != null) {
      data["_links"] = links?.toJson();
    }
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Collection>? collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    if (json["self"] is List) {
      self = json["self"] == null
          ? []
          : (json["self"] as List).map((e) => Self.fromJson(e)).toList();
    }
    if (json["collection"] is List) {
      collection = json["collection"] == null
          ? []
          : (json["collection"] as List)
              .map((e) => Collection.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["self"] = self?.map((e) => e.toJson()).toList();
    data["collection"] = collection?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  Collection.fromJson(Map<String, dynamic> json) {
    if (json["href"] is String) {
      href = json["href"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["href"] = href;
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    if (json["href"] is String) {
      href = json["href"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["href"] = href;
    return data;
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["key"] is String) {
      key = json["key"];
    }
    if (json["value"] is String) {
      value = json["value"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["key"] = key;
    data["value"] = value;
    return data;
  }
}

class Images {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Images(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    if (json["date_created_gmt"] is String) {
      dateCreatedGmt = json["date_created_gmt"];
    }
    if (json["date_modified"] is String) {
      dateModified = json["date_modified"];
    }
    if (json["date_modified_gmt"] is String) {
      dateModifiedGmt = json["date_modified_gmt"];
    }
    if (json["src"] is String) {
      src = json["src"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["alt"] is String) {
      alt = json["alt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["date_created"] = dateCreated;
    data["date_created_gmt"] = dateCreatedGmt;
    data["date_modified"] = dateModified;
    data["date_modified_gmt"] = dateModifiedGmt;
    data["src"] = src;
    data["name"] = name;
    data["alt"] = alt;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["slug"] = slug;
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    if (json["length"] is String) {
      length = json["length"];
    }
    if (json["width"] is String) {
      width = json["width"];
    }
    if (json["height"] is String) {
      height = json["height"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["length"] = length;
    data["width"] = width;
    data["height"] = height;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<dynamic>? options;

  Attributes(
      {this.id,
      this.name,
      this.position,
      this.visible,
      this.variation,
      this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    position = json["position"];
    visible = json["visible"];
    variation = json["variation"];
    options = json["options"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
