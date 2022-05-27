import '../EM/model/v2/products_response/all_products_response_model.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductInitialState extends ProductsState {
  const ProductInitialState();
}

class ProductLoadingState extends ProductsState {
  const ProductLoadingState();
}

class ProductSuccessState extends ProductsState {
  final List<AllProductsResponseModel> productsList;

  ProductSuccessState(this.productsList);
}

class ProductErrorState extends ProductsState {
  final String error;

  const ProductErrorState({
    required this.error,
  });
}
