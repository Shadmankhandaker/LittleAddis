import 'package:love/ENG/model/getAddress_modal.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetAddressBloc {
  final getAddress = PublishSubject<GetAddressModal>();

  Stream<GetAddressModal> get getAddressStream => getAddress.stream;

  Future getAddressSink(String userID) async {
    GetAddressModal getAddressModal =
        await Repository().getAddressRepository(userID);
    getAddress.sink.add(getAddressModal);
  }

  dispose() {
    getAddress.close();
  }
}

final getAddressBloc = GetAddressBloc();
