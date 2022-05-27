import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/loginscreenEng.dart';
import 'package:love/models/forget_password/forget_password_response.dart';
import 'package:love/utils/color_utils.dart';
import 'package:love/woocommerce/woocommerce_api_forget_password.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailverify = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                    Navigator.of(context).pop(LogInScreenEng);
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
                                    child: new TextFormField(
                                  obscureText: false,
                                  controller: _emailverify,
                                  decoration: new InputDecoration(
                                      labelText: "Email-Id",
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
                                              'Submit',
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
                                              onPressed: () async {
                                                SystemChannels.textInput
                                                    .invokeMethod(
                                                        'TextInput.hide');
                                                // Loader().showIndicator(context);
                                                String pattern =
                                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                RegExp regex =
                                                    new RegExp(pattern);
                                                if (regex.hasMatch(
                                                    _emailverify.text)) {
                                                  try {
                                                    Loader()
                                                        .showIndicator(context);

                                                    WooCommerceAPI
                                                        wooCommerceAPI =
                                                        new WooCommerceAPI(
                                                            url:
                                                                '${baseUrl2()}',
                                                            consumerKey:
                                                                "${consumerKey()}",
                                                            consumerSecret:
                                                                "${consumerSecret()}");

                                                    var map = new Map();
                                                    map['user_login'] =
                                                        _emailverify.text;

                                                    final response =
                                                        await wooCommerceAPI
                                                            .postAsync(
                                                                'users/lostpassword',
                                                                map);

                                                    final responseModel =
                                                        ForgetPasswordResponseModel
                                                            .fromJson(response);

                                                    Loader()
                                                        .hideIndicator(context);

                                                    if (responseModel.code ==
                                                        "200") {
                                                      Navigator.pop(context);
                                                      forgoterrorDialog(context,
                                                          "${responseModel.message}");
                                                    } else {
                                                      forgoterrorDialog(context,
                                                          "${responseModel.message}");
                                                    }
                                                  } on Exception {
                                                    Loader()
                                                        .hideIndicator(context);
                                                    forgoterrorDialog(context,
                                                        "Email incorrect or No Internet connection");

                                                    throw Exception(
                                                        'Email incorrect or No Internet connection');
                                                  }
                                                } else {
                                                  forgoterrorDialog(context,
                                                      "Enter valid E-mail");
                                                }
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
}
