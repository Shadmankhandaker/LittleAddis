import 'dart:io';

import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:love/models/profile_pic/profile_pic_response_model.dart';
import 'package:love/models/profile_response/profile_response_model.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _profile = PublishSubject<ProfileModal>();
  final _profileData = PublishSubject<ProfileResponseModel>();

  Stream<ProfileModal> get profileStream => _profile.stream;
  Stream<ProfileResponseModel> get profileInfoStream => _profileData.stream;

  Future profileSink(String userID) async {
    ProfileModal profileModal = await Repository().profileRepository(userID);
    _profile.sink.add(profileModal);
  }

  Future getProfileInfo(String userID) async {
    ProfileResponseModel profileModal =
        await Repository().getProfileInfo(userID);
    _profileData.sink.add(profileModal);
  }

  Future<ProfileResponseModel> updateProfileInfo(String userId,
      String firstName, String lastName, String email, String phoneNumber,
      {String? url}) async {
    return await Repository().updateProfile(
        userId, firstName, lastName, email, phoneNumber,
        url: url);
  }

  Future<ProfilePicResponseModel> uploadProfilePic(File image) async {
    return await Repository().uploadProfilePicture(image);
  }

  dispose() {
    _profile.close();
    _profileData.close();
  }
}

final profileBloc = ProfileBloc();
