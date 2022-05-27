import 'package:flutter_bloc/flutter_bloc.dart';

import '../EM/model/v2/products_response/all_products_response_model.dart';
import '../events/products_event.dart';
import '../events/products_state.dart';
import '../repository/products_repo.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;
  int page = 1;
  bool isFetching = false;

  ProductsBloc(this.repository) : super(ProductInitialState());

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is ProductsFetchEvent) {
      String lang = event.language;

      yield ProductLoadingState();

      final response = await repository.productApi(page, lang);

      if (response is String) {
        yield ProductErrorState(error: response);
      } else if (response is List<AllProductsResponseModel>) {
        yield ProductSuccessState(response);
        page++;
      }
    }
  }
}
