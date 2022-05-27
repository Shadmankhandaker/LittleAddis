import 'package:flutter/material.dart';

import '../models/orders/orders_response_model.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrdersInitialState extends OrdersState {
  const OrdersInitialState();
}

class OrdersLoadingState extends OrdersState {
  const OrdersLoadingState();
}

class OrdersSuccessState extends OrdersState {
  final List<OrdersResponseModel> ordersList;

  OrdersSuccessState(this.ordersList);
}

class OrdersErrorState extends OrdersState {
  final String error;

  const OrdersErrorState({
    required this.error,
  });
}
