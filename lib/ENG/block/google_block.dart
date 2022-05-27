import 'package:love/ENG/model/google_model.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GoogleBloc {
  final _googleBlocController = PublishSubject<GoogleModel>();

  Stream<GoogleModel> get googleStream => _googleBlocController.stream;

  Future<GoogleModel> googleSink(
    String username,
    String email,
    String type,
  ) async {
    return await Repository().googleRepository(username, email, type);
  }

  dispose() {
    _googleBlocController.close();
  }
}

final googleBloc = GoogleBloc();
