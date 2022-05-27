import 'dart:io';
import 'package:love/ENG/model/newAddress_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:love/models/address/billing_body.dart';
import 'package:love/models/address/shipping_body.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/address/address_response_model.dart';

class AddressBloc {
  final _addressBlocController = PublishSubject<AddressModel>();
  final _addressDetailsController = PublishSubject<AddressResponseModel>();

  Stream<AddressModel> get addressStream => _addressBlocController.stream;
  Stream<AddressResponseModel> get addressDetailController =>
      _addressDetailsController.stream;

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

  Future<AddressResponseModel> putAddress(
      String userId,
      String firstName,
      String lastName,
      String number,
      String email,
      String postCode,
      String address1,
      String address2,
      String countryOrCity) async {
    BillingBody billingBody = BillingBody();
    ShippingBody shippingBody = ShippingBody();

    billingBody.firstName = firstName;
    billingBody.lastName = lastName;
    billingBody.phone = number;
    billingBody.email = email;
    billingBody.postcode = postCode;
    billingBody.address1 = address1;
    billingBody.address2 = address2;
    billingBody.city = countryOrCity;
    billingBody.country = countryOrCity;
    billingBody.state = countryOrCity;
    billingBody.company = '';

    shippingBody.firstName = firstName;
    shippingBody.lastName = lastName;
    shippingBody.postcode = postCode;
    shippingBody.address1 = address1;
    shippingBody.address2 = address2;
    shippingBody.city = countryOrCity;
    shippingBody.country = countryOrCity;
    shippingBody.state = countryOrCity;
    shippingBody.company = '';

    return await Repository().putAddress(userId, billingBody, shippingBody);
  }

  getAddress(int userId) async {
    var response = await Repository().getAddressDetails(userId);
    if (response.role != null) {
      if (response.role != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(
            SharedPreferencesKey.USER_ROLE, response.role ?? "");
      }
    }

    _addressDetailsController.sink.add(response);
  }

  dispose() {
    _addressBlocController.close();
    _addressDetailsController.close();
  }
}

final addressBloc = AddressBloc();
