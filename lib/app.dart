import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EM/Screens/homescreen.dart';
import 'EM/Screens/loginscreen.dart';
import 'ENG/Screens/homescreenEng.dart';
import 'ENG/Screens/loginscreenEng.dart';

import 'global.dart';
import 'share_preference/preferencesKey.dart';

class App extends StatelessWidget {
  final SharedPreferences prefs;

  App(this.prefs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _handleCurrentScreen(prefs),
    );
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    String? data = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    preferences = prefs;

    String? userDataStr = preferences?.getString(SharedPreferencesKey.Language);

    if (userDataStr == null) {
      if (data == null) {
        return LogInScreenEng();
      } else {
        return MyHome();
      }
    } else {
      if (data == null) {
        return LogInScreenEng();
      } else {
        return MyHomeEng();
      }
    }
  }
}
