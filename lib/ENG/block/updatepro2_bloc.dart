import 'dart:io';

import 'package:love/ENG/model/updateprofile2_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UpdateproBloc2 {
  final _updateproBlocController2 = PublishSubject<UpdateproModel2>();

  Stream<UpdateproModel2> get addressStream2 =>
      _updateproBlocController2.stream;

  Future<UpdateproModel2> updateproSink2(
    String number,
    String fname,
    String gender,
    String email,
    String bdate,
    String location,
    String userId,
  ) async {
    return await Repository().updateproRepository2(
      number,
      fname,
      gender,
      email,
      bdate,
      location,
      userId,
    );
  }

  dispose() {
    _updateproBlocController2.close();
  }
}

final updateproBloc2 = UpdateproBloc2();
