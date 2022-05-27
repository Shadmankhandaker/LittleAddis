import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:love/EM/block/google_block.dart';
import 'package:love/EM/model/google_model.dart';
import 'package:love/global.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
String? imageUrl;
String data = "";
Future<String> signInWithGoogle() async {
  final googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication?.accessToken,
    idToken: googleSignInAuthentication?.idToken,
  );

  final authResult = await _auth.signInWithCredential(credential);
  final user = authResult.user;

  // Checking if email and name is null
  assert(user?.email != null);
  assert(user?.displayName != null);
  assert(user?.photoURL != null);

  name = user?.displayName;
  email = user?.email;
  imageUrl = user?.photoURL;

  // Only taking the first part of the name, i.e., First Name
  if (name?.contains(" ") ?? false) {
    name = name?.substring(0, name?.indexOf(" "));
  }

  assert(!(user?.isAnonymous ?? false));
  assert(await user?.getIdToken() != null);

  final currentUser = _auth.currentUser;
  assert(user?.uid == currentUser?.uid);

  googleBloc
      .googleSink(
    name ?? "",
    email ?? "",
    "google",
  )
      .then((userResponse) async {
    if (userResponse.responseCode == "1") {
      String userResponseStr = json.encode(userResponse);

      googleBloc.dispose();
      print(userResponse.user?.id);
      userID = userResponse.user?.id.toString();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(
          SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
    } else if (userResponse.responseCode == '0') {
    } else {}
  });

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
