import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:rxdart/rxdart.dart';

class UserOrdersBloc {
  final userorders = PublishSubject<UserOrdersModel>();
  final allOrders = PublishSubject<List<OrdersResponseModel>>();

  Stream<UserOrdersModel> get userordersStream => userorders.stream;
  Stream<List<OrdersResponseModel>> get allOrdersStream => allOrders.stream;

  Future userordersSink(String userID) async {
    UserOrdersModel nearbyModal =
        await Repository().userordersRepository(userID);
    userorders.sink.add(nearbyModal);
  }

  getOrders() async {
    var response = await Repository().getOrders();
    allOrders.sink.add(response);
  }

  dispose() {
    userorders.close();
    allOrders.close();
  }
}

final userOrdersBloc = UserOrdersBloc();
