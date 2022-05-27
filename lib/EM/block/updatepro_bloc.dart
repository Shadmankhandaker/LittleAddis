import 'dart:io';

import 'package:love/ENG/model/updateprofile_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UpdateproBloc {
  final _updateproBlocController = PublishSubject<UpdateproModel>();

  Stream<UpdateproModel> get addressStream => _updateproBlocController.stream;

  Future<UpdateproModel> updateproSink(
    String number,
    String fname,
    String gender,
    String email,
    String bdate,
    String location,
    String userId,
    File profilePic,
  ) async {
    return await Repository().updateproRepository(
        number, fname, gender, email, bdate, location, userId, profilePic);
  }

  dispose() {
    _updateproBlocController.close();
  }
}

final updateproBloc = UpdateproBloc();
