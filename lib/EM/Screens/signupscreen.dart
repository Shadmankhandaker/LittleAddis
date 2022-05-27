import 'package:love/Constant.dart';
import 'package:love/global.dart';
import 'package:love/EM/Screens/loginscreen.dart';
import 'package:love/EM/block/signup_bloc.dart';
import 'package:love/strings/strings.dart';
import 'package:love/utils/color_utils.dart' show HexColor;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'HomeScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  ProgressDialog? pr;

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: new Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 90.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
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
                                new Card(
                                  elevation: 10,
                                  child: new TextFormField(
                                    controller: _firstnameController,
                                    decoration: new InputDecoration(
                                        labelText: "የመጀመሪያ ስም ያስገቡ *",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                                right: 10.0, left: 10),
                                            child: new Image.asset(
                                              "assets/images/name.png",
                                              height: 10.0,
                                              width: 10.0,
                                              fit: BoxFit.scaleDown,
                                            ))),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                new Card(
                                  elevation: 10,
                                  child: new TextFormField(
                                    controller: _lastnameController,
                                    decoration: new InputDecoration(
                                        labelText: "የአያት ስም ያስገቡ *",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                                right: 10.0, left: 10),
                                            child: new Image.asset(
                                              "assets/images/name.png",
                                              height: 10.0,
                                              width: 10.0,
                                              fit: BoxFit.scaleDown,
                                            ))),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                new Card(
                                    child: new TextFormField(
                                  obscureText: false,
                                  controller: _emailController,
                                  decoration: new InputDecoration(
                                      labelText: "ኢሜል-መታወቂያ *",
                                      labelStyle: TextStyle(
                                        color: HexColor('#004851'),
                                      ),
                                      enabled: true,
                                      filled: false,
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              right: 7.0, left: 10),
                                          child: new Image.asset(
                                            "assets/images/mail.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ))),
                                  keyboardType: TextInputType.text,
                                )),
                                new Card(
                                    child: new TextFormField(
                                  obscureText: false,
                                  controller: _phoneController,
                                  decoration: new InputDecoration(
                                      labelText: "ስልክ ቁጥር",
                                      labelStyle: TextStyle(
                                        color: HexColor('#004851'),
                                      ),
                                      enabled: true,
                                      filled: false,
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              right: 7.0, left: 10),
                                          child: new Image.asset(
                                            "assets/images/pmobile.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ))),
                                  keyboardType: TextInputType.number,
                                )),
                                new Card(
                                    child: new TextFormField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: new InputDecoration(
                                      labelText: "የይለ  ፍ ቃል*",
                                      labelStyle: TextStyle(
                                        color: HexColor('#004851'),
                                      ),
                                      enabled: true,
                                      filled: false,
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
                                  width: 400,
                                  padding: EdgeInsets.only(
                                      left: 0.0, top: 45.0, bottom: 20.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'ክፈት',
                                              textAlign: TextAlign.right,
                                              style: new TextStyle(
                                                fontSize: 35.0,
                                                color: HexColor('#004851'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 15),
                                        Column(
                                          children: [
                                            FloatingActionButton(
                                              backgroundColor:
                                                  HexColor('#004851'),
                                              onPressed: () {
                                                _signup(context);
                                              },
                                              child: new Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.white,
                                                size: 35.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _signup(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr?.style(message: 'የተወሰነ እድገት በማሳየት ላይ ...');
    pr?.style(
      message: 'እባክዎ ይጠብቁ...',
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

    closeKeyboard();
    if (_firstnameController.text.isNotEmpty) {
      if (_lastnameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty) {
        // Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        //  RegExp regex = new RegExp(pattern);
        if (_emailController.text.length > 6 &&
            _passwordController.text.length > 4) {
          pr?.show();

          signupBloc
              .signupSink(
            _firstnameController.text,
            _lastnameController.text,
            _emailController.text,
            "normal",
            _phoneController.text,
            _passwordController.text,
          )
              .then(
            (userResponse) {
              if (userResponse.message == null) {
                // String userResponseStr = json.encode(userResponse);
                // preferences.setString(
                //     SharedPreferencesKey.LOGGED_IN_USERRDATA,
                //     userResponseStr);
                //Loader().hideIndicator(context);
                signupBloc.dispose();
                pr?.hide();
                errorDialog(
                  context,
                  "በተሳካ ሁኔታ መለያ ፈጥረዋል ፣ ለመቀጠል እባክዎ ይግቡ።",
                  button: true,
                );

                signupBloc.dispose();
                pr?.hide();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                );
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //     builder: (context) => TabbarScreen(),
                //   ),
                //   (Route<dynamic> route) => false,
                // );
              } else {
                pr?.hide();
                errorDialog(context, userResponse.message.split(".")[0]);
                // Loader().hideIndicator(context);
              }
            },
          );
        } else {
          pr?.hide();
          errorDialog(context, "የቀኝ ምስክር ወረቀት ማስገባትዎን ያረጋግጡ");
        }
      } else {
        pr?.hide();
        errorDialog(context, "ለመመዝገብ እባክዎ ትክክለኛ ማረጋገጫ ያስገቡ");
      }
    } else {
      pr?.hide();
      errorDialog(context, "ለመመዝገብ እባክዎ ትክክለኛ ማረጋገጫ ያስገቡ");
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _firstnameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
