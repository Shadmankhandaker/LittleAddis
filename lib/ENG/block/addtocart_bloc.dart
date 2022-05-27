import 'dart:io';
import 'package:love/ENG/model/addtocart_model.dart';
import 'package:love/ENG/model/signup_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AddtocartBloc {
  final _addtocartBlocController = PublishSubject<AddtocartModel>();

  Stream<AddtocartModel> get addtocartStream => _addtocartBlocController.stream;

  Future<AddtocartModel> addtocartSink(
      String userId, String productId, String quantity) async {
    return await Repository().addtocartRepository(userId, productId, quantity);
  }

  dispose() {
    _addtocartBlocController.close();
  }
}

final addtoacartBloc = AddtocartBloc();
