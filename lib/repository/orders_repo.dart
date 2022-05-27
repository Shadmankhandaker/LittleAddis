import '../EM/model/v2/products_response/all_products_response_model.dart';
import '../global.dart';
import '../woocommerce/woocommerce_api.dart';

class OrdersRepository {
  static final OrdersRepository _ordersRepository = OrdersRepository._();

  OrdersRepository._();

  factory OrdersRepository() {
    return _ordersRepository;
  }

  Future<dynamic> getOrdersApi(int page) async {
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: '${baseUrl2()}',
          consumerKey: "${consumerKey()}",
          consumerSecret: "${consumerSecret()}");

      List responseJson = [];

      responseJson = await wooCommerceAPI.getAsync("products?page=$page");

      return responseJson
          .map((m) => AllProductsResponseModel.fromJson(m))
          .toList();
    } catch (e) {
      return e.toString();
    }
  }
}
