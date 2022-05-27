import 'dart:io';
import 'package:rxdart/rxdart.dart';

import '../../ENG/model/newAddress_model.dart';
import '../../ENG/repository/repository.dart';

class AddressBloc {
  final _addressBlocController = PublishSubject<AddressModel>();

  Stream<AddressModel> get addressStream => _addressBlocController.stream;

  Future<AddressModel> addressSink(
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
    return await Repository().addressRepository(
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

  dispose() {
    _addressBlocController.close();
  }
}

final addressBloc = AddressBloc();
