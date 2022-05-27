import 'package:rxdart/rxdart.dart';

import '../../ENG/repository/repository.dart';
import '../model/v2/products_response/all_products_response_model.dart';

class AllProductBloc {
  final product = PublishSubject<List<AllProductsResponseModel>>();

  Stream<List<AllProductsResponseModel>> get allProductStream => product.stream;

  Future productSink() async {
    var model = await Repository().allProductRepository(0);
    // product.sink.add(model);
  }

  dispose() {
    product.close();
  }
}

final allproductblog = AllProductBloc();
