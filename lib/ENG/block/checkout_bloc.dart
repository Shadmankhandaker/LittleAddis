import 'package:love/EM/Screens/google_sign_in.dart';
import 'package:love/ENG/model/checkout_modal.dart';
import 'package:love/ENG/model/deletecart_modal.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:love/models/payment_stripe/payment_body.dart';
import 'package:love/models/payment_stripe/payment_response_model.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc {
  final checkout = PublishSubject<CheckoutModel>();

  Stream<CheckoutModel> get checkoutStream => checkout.stream;

  Future checkoutSink(
      String userId, String total, String paymentMode, String address) async {
    CheckoutModel checkoutModal = await Repository()
        .checkoutRepository(userId, total, paymentMode, address);
    checkout.sink.add(checkoutModal);
  }

  dispose() {
    checkout.close();
  }

  Future<PaymentResponseModel> checkoutApi(
      String amount, String token, String orderId) async {
    Map<String, String> dataMap = {};

    dataMap["token"] = token;
    dataMap["amount"] = amount;
    dataMap["orderId"] = orderId;

    return await Repository().makePayment(dataMap);
  }
}

final checkoutBloc = CheckoutBloc();
