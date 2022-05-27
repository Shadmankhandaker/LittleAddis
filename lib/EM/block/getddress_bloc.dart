import 'package:rxdart/rxdart.dart';

import '../../ENG/model/getAddress_modal.dart';
import '../../ENG/repository/repository.dart';

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
