import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserOrdersBloc {
  final userorders = PublishSubject<UserOrdersModel>();

  Stream<UserOrdersModel> get userordersStream => userorders.stream;

  Future userordersSink(String userID) async {
    UserOrdersModel nearbyModal =
        await Repository().userordersRepository(userID);
    userorders.sink.add(nearbyModal);
  }

  dispose() {
    userorders.close();
  }
}

final userordersbloc = UserOrdersBloc();
