import 'dart:io';

import 'package:love/EM/model/v2/products_response/all_products_response_model.dart';
import 'package:love/ENG/model/addtocart_model.dart';
import 'package:love/ENG/model/blog_model.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/ENG/model/checkout_modal.dart';
import 'package:love/ENG/model/deletecart_modal.dart';
import 'package:love/ENG/model/getAddress_modal.dart';
import 'package:love/ENG/model/google_model.dart';
import 'package:love/ENG/model/newAddress_model.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/ENG/model/repeatOrder_model.dart';
import 'package:love/ENG/model/search_model.dart';
import 'package:love/ENG/model/updateCart_model.dart';
import 'package:love/ENG/model/updateprofile2_model.dart';
import 'package:love/ENG/model/updateprofile_model.dart';
import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/ENG/provider/address_api.dart';
import 'package:love/ENG/provider/addtocart_api.dart';
import 'package:love/ENG/provider/allproduct_api.dart';
import 'package:love/ENG/provider/blog_api.dart';
import 'package:love/ENG/provider/cartproduct_api.dart';
import 'package:love/ENG/provider/checkout_api.dart';
import 'package:love/ENG/provider/deletecart_api.dart';
import 'package:love/ENG/provider/getAddress_api.dart';
import 'package:love/ENG/provider/google_api.dart';
import 'package:love/ENG/provider/login_api.dart';
import 'package:love/ENG/provider/profile_api.dart';
import 'package:love/ENG/provider/recipe_api.dart';
import 'package:love/ENG/provider/reorder_api.dart';
import 'package:love/ENG/provider/search_api.dart';
import 'package:love/ENG/provider/signup_api.dart';
import 'package:love/ENG/provider/updateCart_api.dart';
import 'package:love/ENG/provider/updatepro2_api.dart';
import 'package:love/ENG/provider/updatepro_api.dart';
import 'package:love/ENG/provider/userorders_api.dart';
import 'package:love/models/address/address_response_model.dart';
import 'package:love/models/address/billing_body.dart';
import 'package:love/models/address/shipping_body.dart';
import 'package:love/models/cart/add_to_cart_body.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/login/login_body.dart';
import 'package:love/models/login/login_response_model.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/models/orders/place_order_body.dart';
import 'package:love/models/payment_stripe/payment_response_model.dart';
import 'package:love/models/profile_pic/profile_pic_response_model.dart';
import 'package:love/models/profile_response/profile_response_model.dart';
import 'package:love/models/signup/sign_up_body.dart' as signupBody;
import 'package:love/models/signup/sign_up_body.dart';
import 'package:love/models/signup/sign_up_response_model.dart';
import 'package:love/models/validate_token/token_validate_response_model.dart';

import '../model/recipe_response_model.dart';

class Repository {
  Future<LoginResponseModel> loginApiRepository(
      String email, String password) async {
    LoginBody body = LoginBody(username: email, password: password);
    return await LoginApi().loginUser(body);
  }

  Future<TokenValidateResponseModel> tokenValidate(
      String token, String email, String password) async {
    return await LoginApi().tokenValidate(token, email, password);
  }

  Future<SignUpResponseModel> signupRepository(
      String firstName,
      String lastName,
      String email,
      String type,
      String phone,
      String password) async {
    List<signupBody.Meta_data> numberMetaData = [];
    numberMetaData
        .add(signupBody.Meta_data(key: "mobile_number", value: phone));

    SignUpBody body = SignUpBody(
        email: email,
        username: email,
        lastName: lastName,
        password: password,
        metaData: numberMetaData,
        firstName: firstName);

    return await SignupApi().signUpApiNew(body);
  }

  Future<GoogleModel> googleRepository(
      String username, String email, String type) async {
    return await GoogleApi().googleApi(username, email, type);
  }

  Future<List<AllProductsResponseModel>> allProductRepository(int page) async {
    return await AllProductApi().productApi(page);
  }

  Future<BlogModel> blogRepository() async {
    return await BlogApi().blogApi();
  }

  Future<RecipeResponseModel> recipeRepository() async {
    return await RecipeApi().recipeApi();
  }

  Future<UserOrdersModel> userordersRepository(String userID) async {
    return await UserOrdersApi().userordersApi(userID);
  }

  Future<CartProductModel> cartProductRepository(String userID) async {
    return await CartProductApi().cartApi(userID);
  }

  Future<bool> addToCartApi(AddToCartBody body, String token) async {
    return await CartProductApi().addToCartApi(body, token);
  }

  Future<CartDataResponseModel> getCartData(String token) async {
    return await CartProductApi().getCartData(token);
  }

  Future<bool> deleteCartData(String token, String cartKey) async {
    return await CartProductApi().deleteCart(cartKey, token);
  }

  Future<String> cartCount(String token) async {
    return await CartProductApi().cartCount(token);
  }

  Future<bool> updateCartItem(
      String token, String cartKey, int quantity) async {
    return await CartProductApi().updateCartQuantity(token, cartKey, quantity);
  }

  Future<ProfileModal> profileRepository(String userID) async {
    return await ProfileApi().profileApi(userID);
  }

  Future<ProfileResponseModel> getProfileInfo(String userID) async {
    return await ProfileApi().getProfileInfo(userID);
  }

  Future<ProfileResponseModel> updateProfile(String userId, String firstName,
      String lastName, String email, String phoneNumber,
      {String? url}) async {
    return await ProfileApi().updateProfileInfo(
        userId, firstName, lastName, email, phoneNumber,
        url: url ?? "");
  }

  Future<ProfilePicResponseModel> uploadProfilePicture(File image) async {
    var response = ProfileApi().uploadProfile(image);
    return response;
  }

  Future<GetAddressModal> getAddressRepository(String userID) async {
    return await GetAddressApi().getAddressApi(userID);
  }

  Future<DeleteCartModel> deletecartRepository(String cartId) async {
    return await DeleteCartApi().deletecartApi(cartId);
  }

  Future<UpdateCartModel> updatecartRepository(
      String cartId, String quantity, String userId, String productId) async {
    return await UpdateCartApi()
        .updatecartApi(cartId, quantity, userId, productId);
  }

  Future<CheckoutModel> checkoutRepository(
      String userId, String total, String paymentMode, String address) async {
    return await CheckoutApi().checkoutApi(userId, total, paymentMode, address);
  }

  Future<AddressModel> addressRepository(
      String userId,
      String userName,
      String userMobile,
      String addressPin,
      String addressState,
      String addressTown,
      String addressCity,
      String addressType,
      String addressOpenSat,
      String addressOpenSun) async {
    return await AddressApi().addressApi(
        userId,
        userName,
        userMobile,
        addressPin,
        addressState,
        addressTown,
        addressCity,
        addressType,
        addressOpenSat,
        addressOpenSun);
  }

  Future<AddressModel> addNewAddressRepository(
      String userId,
      String userName,
      String userMobile,
      String addressPin,
      String addressState,
      String addressTown,
      String addressCity,
      String addressType,
      String addressOpenSat,
      String addressOpenSun) async {
    return await AddressApi().addressApi(
        userId,
        userName,
        userMobile,
        addressPin,
        addressState,
        addressTown,
        addressCity,
        addressType,
        addressOpenSat,
        addressOpenSun);
  }

  Future<SearchModal> searchRepository(String name) async {
    return await SearchApi().searchApi(name);
  }

  Future<List<AllProductsResponseModel>> getProductSearch(String search) async {
    return await SearchApi().searchProduct(search);
  }

  Future<UpdateproModel> updateproRepository(
      String number,
      String fname,
      String gender,
      String email,
      String bdate,
      String location,
      String userId,
      File profilePic) async {
    return await UpdateproApi().updateproApi(
        number, fname, gender, email, bdate, location, userId, profilePic);
  }

  Future<UpdateproModel2> updateproRepository2(
    String number,
    String fname,
    String gender,
    String email,
    String bdate,
    String location,
    String userId,
  ) async {
    return await UpdateproApi2().updateproApi(
      number,
      fname,
      gender,
      email,
      bdate,
      location,
      userId,
    );
  }

  Future<AddtocartModel> addtocartRepository(
      String userId, String productId, String quantity) async {
    return await AddtocartApi().addtocartApi(userId, productId, quantity);
  }

  Future<ReorderModel> reorderRepository(String orderId) async {
    return await ReorderApi().reorderApi(orderId);
  }

  Future<AddressResponseModel> putAddress(
      String userId, BillingBody billingBody, ShippingBody shippingBody) async {
    return await AddressApi().putAddress(userId, billingBody, shippingBody);
  }

  Future<AddressResponseModel> getAddressDetails(int id) async {
    return await AddressApi().getAddress(id);
  }

  Future<OrdersResponseModel> placeOrder(PlaceOrderBody body) async {
    return await cartproductApi.placeOrder(body);
  }

  Future<PaymentResponseModel> makePayment(Map<String, String> dataMap) async {
    return await CheckoutApi().makePayment(dataMap);
  }

  Future<List<OrdersResponseModel>> getOrders() async {
    return await UserOrdersApi().getOrders();
  }
}
