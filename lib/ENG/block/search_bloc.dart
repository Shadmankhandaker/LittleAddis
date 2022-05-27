import 'package:love/EM/model/v2/products_response/all_products_response_model.dart';
import 'package:love/ENG/model/search_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final _search = PublishSubject<SearchModal>();
  final _searchResult = PublishSubject<List<AllProductsResponseModel>>();

  Stream<SearchModal> get searchStream => _search.stream;
  Stream<List<AllProductsResponseModel>> get searchResult =>
      _searchResult.stream;

  Future searchSink(String name) async {
    SearchModal searchModal = await Repository().searchRepository(name);
    _search.sink.add(searchModal);
  }

  searchProducts(String search) async {
    List<AllProductsResponseModel> list =
        await Repository().getProductSearch(search);

    _searchResult.sink.add(list);
  }

  dispose() {
    _search.close();
    _searchResult.close();
  }
}

final searchBloc = SearchBloc();
