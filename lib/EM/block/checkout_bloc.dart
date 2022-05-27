import 'package:rxdart/rxdart.dart';

import '../../ENG/model/checkout_modal.dart';
import '../../ENG/repository/repository.dart';

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
}

final checkoutBloc = CheckoutBloc();
