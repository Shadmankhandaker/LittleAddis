import 'package:love/EM/model/v2/products_response/all_products_response_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AllProductBloc {
  final product = PublishSubject<List<AllProductsResponseModel>>();

  Stream<List<AllProductsResponseModel>> get allProductStream => product.stream;

  Future productSink(int page) async {
    List<AllProductsResponseModel> nearbyModal =
        await Repository().allProductRepository(page);
    product.sink.add(nearbyModal);
  }

  dispose() {
    product.close();
  }
}

final allproductblog = AllProductBloc();
