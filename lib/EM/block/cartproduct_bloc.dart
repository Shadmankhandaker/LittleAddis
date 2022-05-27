import 'package:rxdart/rxdart.dart';

import '../../ENG/model/cartproduct_model.dart';
import '../../ENG/repository/repository.dart';
import '../../models/cart/add_to_cart_body.dart';
import '../../models/cart/cart_response_model.dart';
import '../../models/cart/cartdata_response_model.dart';

class CartBloc {
  final cart = PublishSubject<CartProductModel>();

  final cartNew = PublishSubject<CartResponseModel>();
  final getCart = PublishSubject<CartDataResponseModel>();
  final cartDelete = PublishSubject<bool>();
  final cartCount = PublishSubject<String>();

  Stream<CartProductModel> get cartStream => cart.stream;
  Stream<CartResponseModel> get cartStreamNew => cartNew.stream;
  Stream<CartDataResponseModel> get getCartStream => getCart.stream;
  Stream<bool> get getCartDeleteStream => cartDelete.stream;
  Stream<String> get cartCountStream => cartCount.stream;

  Future cartSink(String userID) async {
    CartProductModel cartProductModel =
        await Repository().cartProductRepository(userID);
    cart.sink.add(cartProductModel);
  }

  Future cartSinkNew(AddToCartBody model, String token) async {
    var response = await Repository().addToCartApi(model, token);
    // cartNew.sink.add(response);
  }

  Future getCartSink(String token) async {
    CartDataResponseModel response = await Repository().getCartData(token);
    getCart.sink.add(response);
  }

  deleteCartSink(String token, String cartKey) async {
    bool response = await Repository().deleteCartData(token, cartKey);
    cartDelete.sink.add(response);
  }

  getCartCount(String token) async {
    String response = await Repository().cartCount(token);
    cartCount.sink.add(response);
  }

  dispose() {
    cart.close();
    cartNew.close();
    getCart.close();
    cartDelete.close();
    cartCount.close();
  }
}

final cartBlock = CartBloc();
