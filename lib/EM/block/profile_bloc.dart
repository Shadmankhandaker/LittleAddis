import 'package:love/EM/repository/repository.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _profile = PublishSubject<ProfileModal>();

  Stream<ProfileModal> get profileStream => _profile.stream;

  Future profileSink(String userID) async {
    ProfileModal profileModal = await Repository().profileRepository(userID);
    _profile.sink.add(profileModal);
  }

  dispose() {
    _profile.close();
  }
}

final profileBloc = ProfileBloc();
