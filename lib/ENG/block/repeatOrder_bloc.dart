import 'package:love/ENG/model/repeatOrder_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReorderBloc {
  final reorder = PublishSubject<ReorderModel>();

  Stream<ReorderModel> get reorderStream => reorder.stream;

  Future reorderSink(String orderId) async {
    ReorderModel reordertModal = await Repository().reorderRepository(orderId);
    reorder.sink.add(reordertModal);
  }

  dispose() {
    reorder.close();
  }
}

final reorderBloc = ReorderBloc();
