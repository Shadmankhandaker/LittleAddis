// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant.dart';
import 'EM/Screens/splashscreen.dart';
import 'app.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then(
    (prefs) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: HexColor("#0e4951"),
      ));
      runApp(MaterialApp(
        title: 'Little Addis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          primaryColorDark: Colors.black,
          fontFamily: 'Nexa',
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          App_Screen: (BuildContext context) => App(prefs),
//              SIGN_UP_SCREEN: (BuildContext context) => new SignUpScreen(),
//              ANIMATED_SPLASH: (BuildContext context) => new SplashScreen(),
        },
      ));
    },
  );
}
