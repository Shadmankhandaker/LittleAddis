import '../EM/model/v2/products_response/all_products_response_model.dart';
import '../global.dart';
import '../woocommerce/woocommerce_api.dart';

class ProductsRepository {
  static final ProductsRepository _productsRepository = ProductsRepository._();

  ProductsRepository._();

  factory ProductsRepository() {
    return _productsRepository;
  }

  Future<dynamic> productApi(int page, String lang) async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: '${baseUrl2()}',
          consumerKey: "${consumerKey()}",
          consumerSecret: "${consumerSecret()}");

      List responseJson = [];

      responseJson =
          await wooCommerceAPI.getAsync("products?page=$page&lang=$lang");

      return responseJson
          .map((m) => AllProductsResponseModel.fromJson(m))
          .toList();
    } catch (e) {
      return e.toString();
    }
  }
}
