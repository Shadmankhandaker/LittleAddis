import 'package:love/ENG/model/deletecart_modal.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class DeleteCartBloc {
  final deletecart = PublishSubject<DeleteCartModel>();

  Stream<DeleteCartModel> get deletecartStream => deletecart.stream;

  Future deletecartSink(String cartId) async {
    DeleteCartModel deletecartModal =
        await Repository().deletecartRepository(cartId);
    //deletecart.sink.add(deletecartModal);
  }

  dispose() {
    deletecart.close();
  }
}

final deletecartBloc = DeleteCartBloc();
