import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:love/models/cart/add_to_cart_body.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/models/orders/place_order_body.dart' as PlaceOrder;
import 'package:love/models/orders/place_order_body.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final cart = PublishSubject<CartProductModel>();

  final cartNew = PublishSubject<bool>();
  final getCart = PublishSubject<CartDataResponseModel>();
  final cartDelete = PublishSubject<bool>();
  final cartCount = PublishSubject<String>();
  final _cartQuant = PublishSubject<bool>();

  Stream<CartProductModel> get cartStream => cart.stream;
  Stream<bool> get cartStreamNew => cartNew.stream;
  Stream<CartDataResponseModel> get getCartStream => getCart.stream;
  Stream<bool> get getCartDeleteStream => cartDelete.stream;
  Stream<String> get cartCountStream => cartCount.stream;
  Stream<bool> get updateCartQuantStream => _cartQuant.stream;

  cartSink(String userID) async {
    CartProductModel cartProductModel =
        await Repository().cartProductRepository(userID);
    cart.sink.add(cartProductModel);
  }

  cartSinkNew(AddToCartBody model, String token) async {
    bool response = await Repository().addToCartApi(model, token);
    cartNew.sink.add(response);
  }

  getCartSink(String token) async {
    CartDataResponseModel response = await Repository().getCartData(token);

    getCart.sink.add(response);

    if (response.items != null) {
      if (response.items?.length == null) {
        cartCount.sink.add("0");
      } else {
        cartCount.sink.add(response.items?.length.toString());
      }
    }
  }

  deleteCartSink(String token, String cartKey) async {
    bool response = await Repository().deleteCartData(token, cartKey);
    cartDelete.sink.add(response);
  }

  getCartCount(String token) async {
    String response = await Repository().cartCount(token);
    cartCount.sink.add(response);
  }

  updateCartQuant(String token, String cartKey, int quantity) async {
    bool response = await Repository().updateCartItem(token, cartKey, quantity);
    _cartQuant.sink.add(response);
  }

  Future<OrdersResponseModel> placeOrder(
      PlaceOrder.Billing billing,
      PlaceOrder.Shipping shipping,
      List<Items> listItems,
      CartDataResponseModel cart) async {
    PlaceOrderBody body = PlaceOrderBody();
    body.setPaid = false;
    body.paymentMethod = "stripe";
    body.paymentMethodTitle = "Online";
    body.shipping = shipping;
    body.billing = billing;

    List<PlaceOrder.Line_items> items = [];
    List<PlaceOrder.Shipping_lines> shippingLines = [];

    for (var value in listItems) {
      PlaceOrder.Line_items item = PlaceOrder.Line_items();
      item.quantity = value.quantity;
      item.productId = value.productId;
      item.grandTotal = cart.totals?.total;
      items.add(item);

      PlaceOrder.Shipping_lines ship = PlaceOrder.Shipping_lines();
      ship.methodId = "flat_rate";
      ship.methodTitle = "flat_rate";
      ship.total = cart.totals?.shippingTotal;
      shippingLines.add(ship);
    }

    body.lineItems = items;
    body.shippingLines = shippingLines;

    var response = await Repository().placeOrder(body);

    return response;
  }

  dispose() {
    cart.close();
    cartNew.close();
    getCart.close();
    cartDelete.close();
    cartCount.close();
    _cartQuant.close();
  }
}

final cartBlock = CartBloc();
