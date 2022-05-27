import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/EM/Screens/loginscreen.dart';
import 'package:love/EM/Screens/signupscreen.dart' as SignUpEm;
import 'package:love/ENG/Screens/google_sign_in.dart';
import 'package:love/ENG/repository/repository.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/Screens/signupscreen.dart' as SignUpEng;
import 'package:love/ENG/block/login_bloc.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/strings/strings.dart';
import 'package:love/utils/color_utils.dart' show HexColor;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgetpassword.dart';

class LogInScreenEng extends StatefulWidget {
  String? userName;

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreenEng>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  String? uid;
  String dropdownValue = 'English';
  ProgressDialog? pr;
  Repository? repo;

  @override
  void initState() {
    super.initState();
    repo = new Repository();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr?.style(message: 'Showing some progress...');
    pr?.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        height: 10,
        width: 10,
        margin: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/grains_crop.png",
                ),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                colorFilter: new ColorFilter.mode(
                    Colors.white.withOpacity(0.1), BlendMode.dstATop),
              ),
            ),
            child: new ListView(
              shrinkWrap: true,
              reverse: false,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      height: 100.0,
                    ),
                    new Center(
                        child: new Center(
                      child: new Stack(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Form(
                                autovalidateMode: AutovalidateMode.disabled,
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0),
                                              //(x,y)
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 7.0, left: 15),
                                                  child: new Image.asset(
                                                    "assets/images/language.png",
                                                    height: 30.0,
                                                    width: 30.0,
                                                    fit: BoxFit.scaleDown,
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 40),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  value: dropdownValue,
                                                  elevation: 16,
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          hintText: ''),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      dropdownValue =
                                                          newValue ?? "";

                                                      switch (newValue) {
                                                        case "English":
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInScreenEng()),
                                                          );
                                                          break;
                                                        case "Amharic":
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInScreen()),
                                                          );
                                                          break;
                                                      }
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Select Language',
                                                    'English',
                                                    'Amharic',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 40),
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#004851'),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    new Card(
                                      elevation: 10,
                                      child: new TextFormField(
                                        controller: _emailController,
                                        focusNode: _emailFocus,
                                        maxLines: 1,
                                        autofocus: false,
                                        decoration: new InputDecoration(
                                          labelText: "Enter Email ID",
                                          labelStyle: TextStyle(
                                              color: HexColor('#004851'),
                                              fontSize: 14),
                                          prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 7.0, left: 10),
                                              child: new Image.asset(
                                                "assets/images/phone.png",
                                                height: 10.0,
                                                width: 10.0,
                                                fit: BoxFit.scaleDown,
                                              )),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    new Card(
                                        elevation: 10,
                                        child: new TextFormField(
                                          obscureText: true,
                                          autofocus: false,
                                          maxLines: 1,
                                          controller: _passwordController,
                                          focusNode: _passwordFocus,
                                          decoration: new InputDecoration(
                                              labelText: "Enter Password",
                                              labelStyle: TextStyle(
                                                  color: HexColor('#004851'),
                                                  fontSize: 14),
                                              prefixIcon: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 7.0, left: 10),
                                                  child: new Image.asset(
                                                    "assets/images/password_icon.png",
                                                    height: 10.0,
                                                    width: 10.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          keyboardType: TextInputType.text,
                                        )),
                                    new Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          left: 0.0, top: 30.0, bottom: 20.0),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              margin: EdgeInsets.fromLTRB(
                                                  10.0, 5.0, 10.0, 5.0),
                                              child: new RaisedButton(
                                                padding: EdgeInsets.only(
                                                    top: 15.0,
                                                    bottom: 15.0,
                                                    left: 3.0),
                                                color: HexColor('#004851'),
                                                onPressed: () {
                                                  _apiCall(context);
                                                },
                                                child: new Text(
                                                  "Login",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ForgetPassword()),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Forgot Password ?',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: new TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 15.0,
                                                            color: HexColor(
                                                                '#004851'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    googleButton(),
                                    new Column(
                                      children: <Widget>[
                                        new FlatButton(
                                          onPressed: () {
                                            if (dropdownValue == "Amharic") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpEm
                                                              .SignUpScreen()));
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpEng
                                                            .SignUpScreen()),
                                              );
                                            }
                                          },
                                          child: new Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.0, bottom: 20),
                                              child: new Text(
                                                "New User? SignUp",
                                                style: TextStyle(
                                                    fontSize: 25.0,
                                                    color: HexColor("#004851")),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ))
                  ],
                )
              ],
            )));
  }

  void _apiCall(BuildContext context) {
    closeKeyboard();

    if (dropdownValue != "Select Language") {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        pr?.show();
        loginBloc
            .loginSink(
                _emailController.text.trim(), _passwordController.text.trim())
            .then(
          (userResponse) async {
            if (userResponse.success == true) {
              String userResponseStr = json.encode(userResponse.data);

              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString(
                  SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
              preferences.setString(SharedPreferencesKey.JWT_TOKEN,
                  userResponse.data.token ?? "");

              loginBloc
                  .tokenSink(userResponse.data.token ?? "",
                      _emailController.text, _passwordController.text)
                  .then((value) async {
                if (value.success == true && value.statusCode == 200) {
                  if (dropdownValue == "English") {
                    getUserProfileData(userResponse.data.id ?? 0);
                  } else if (dropdownValue == "Amharic") {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MyHome(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                } else {
                  pr?.hide();
                  errorDialog(context, "Unable to validate user");
                }
              });
            } else {
              pr?.hide();
              if (userResponse.message.contains(".")) {
                errorDialog(context, userResponse.message.split(".")[0]);
              } else {
                errorDialog(context, userResponse.message);
              }
            }
          },
        );
      } else {
        pr?.hide();
        //Loader().hideIndicator(context);
        errorDialog(context, "Please enter your credential to login");
      }
    } else {
      pr?.hide();
      errorDialog(context, "Please Select Language");
    }
  }

  void getUserProfileData(int userId) {
    repo?.getProfileInfo(userId.toString()).then((value) async {
      loginBloc.dispose();
      pr?.hide();
      errorDialog(context, "Login Success");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(SharedPreferencesKey.Language, "English");
      preferences.setString(SharedPreferencesKey.USER_ROLE, value.role ?? "");

      print("Got the profile data ${value.role}");

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MyHomeEng(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  Widget googleButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: new RaisedButton(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 3.0),
          color: HexColor('#004851'),
          onPressed: () {
            pr?.show();
            signInWithGoogle().then((value) async {
              pr?.hide();
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString(SharedPreferencesKey.Language, "English");
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MyHomeEng(),
                ),
                (Route<dynamic> route) => false,
              );
              pr?.hide();
            });
          },
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset('assets/images/google.png',
                  color: Colors.white, height: 30),
              new Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Text(
                  "Sign in with Google",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
