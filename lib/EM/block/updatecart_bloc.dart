import 'package:love/ENG/model/updateCart_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UpdateCartBloc {
  final updatecart = PublishSubject<UpdateCartModel>();

  Stream<UpdateCartModel> get updatecartStream => updatecart.stream;

  Future updatecartSink(
      String cartId, String quantity, String userId, String productId) async {
    UpdateCartModel updatecartModal = await Repository()
        .updatecartRepository(cartId, quantity, userId, productId);
    //updatecart.sink.add(updatecartModal);
  }

  dispose() {
    updatecart.close();
  }
}

final updatecartBloc = UpdateCartBloc();
