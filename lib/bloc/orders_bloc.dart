import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/orders_event.dart';
import '../events/orders_state.dart';
import '../models/orders/orders_response_model.dart';
import '../repository/orders_repo.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository repository;
  int page = 1;
  bool isFetching = false;

  OrdersBloc(this.repository) : super(OrdersInitialState());

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if (event is OrdersFetchEvent) {
      yield OrdersLoadingState();
      final response = await repository.getOrdersApi(page);
      if (response is String) {
        yield OrdersErrorState(error: response);
      } else if (response is List<OrdersResponseModel>) {
        yield OrdersSuccessState(response);
        page++;
      }
    }
  }
}
