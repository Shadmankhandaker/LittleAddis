import 'package:love/ENG/model/search_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final _search = PublishSubject<SearchModal>();

  Stream<SearchModal> get searchStream => _search.stream;

  Future searchSink(String name) async {
    SearchModal searchModal = await Repository().searchRepository(name);
    _search.sink.add(searchModal);
  }

  dispose() {
    _search.close();
  }
}

final searchBloc = SearchBloc();
