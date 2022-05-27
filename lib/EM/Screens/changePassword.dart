import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:love/global.dart';
import 'package:love/EM/Screens/loginscreen.dart';
import 'package:love/utils/color_utils.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _oldtpass = TextEditingController();
  final _newpass = TextEditingController();
  final _confirmpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              "assets/images/grains_crop.png",
            ),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1), BlendMode.dstATop),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(LogInScreen);
                                      })),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 90.0,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                    Center(
                        child: Center(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Form(
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Card(
                                        elevation: 10,
                                        child: TextFormField(
                                          obscureText: true,
                                          autofocus: false,
                                          maxLines: 1,
                                          controller: _oldtpass,
                                          decoration: InputDecoration(
                                              labelText: "የአሁኑፓስዎርድ",
                                              labelStyle: TextStyle(
                                                color: HexColor('#004851'),
                                              ),
                                              prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7.0),
                                                  child: Image.asset(
                                                    "assets/images/password_icon.png",
                                                    height: 10.0,
                                                    width: 10.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          keyboardType: TextInputType.text,
                                        )),
                                    Card(
                                        elevation: 10,
                                        child: TextFormField(
                                          obscureText: true,
                                          autofocus: false,
                                          maxLines: 1,
                                          controller: _newpass,
                                          decoration: InputDecoration(
                                              labelText: "አዲስ ፓስዎርድ",
                                              labelStyle: TextStyle(
                                                color: HexColor('#004851'),
                                              ),
                                              prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7.0),
                                                  child: Image.asset(
                                                    "assets/images/password_icon.png",
                                                    height: 10.0,
                                                    width: 10.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          keyboardType: TextInputType.text,
                                        )),
                                    Card(
                                        elevation: 10,
                                        child: TextFormField(
                                          obscureText: true,
                                          autofocus: false,
                                          maxLines: 1,
                                          controller: _confirmpass,
                                          decoration: InputDecoration(
                                              labelText: "የይለፍ ቃል አረጋግጥ",
                                              labelStyle: TextStyle(
                                                color: HexColor('#004851'),
                                              ),
                                              prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7.0),
                                                  child: Image.asset(
                                                    "assets/images/password_icon.png",
                                                    height: 10.0,
                                                    width: 10.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          keyboardType: TextInputType.text,
                                        )),
                                    Container(
                                      width: 400,
                                      padding: const EdgeInsets.only(
                                          left: 0.0, top: 45.0, bottom: 20.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'ያስገቡ',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 35.0,
                                                    color: HexColor('#004851'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              children: [
                                                FloatingActionButton(
                                                  backgroundColor:
                                                      HexColor('#004851'),
                                                  onPressed: () async {
                                                    try {
                                                      final response =
                                                          await client.post(
                                                              Uri.parse(
                                                                  'http://api.thelovegrass.com/api/change_password'),
                                                              body: {
                                                            "user_id": userID,
                                                            "password":
                                                                _oldtpass.text,
                                                            "npassword":
                                                                _newpass.text,
                                                            "cpassword":
                                                                _confirmpass
                                                                    .text,
                                                            // "username":''
                                                          });

                                                      print(_oldtpass.text);
                                                      print(_newpass.text);
                                                      print(_confirmpass.text);

                                                      if (response.statusCode ==
                                                          200) {
                                                        Map<String, dynamic>
                                                            dic = json.decode(
                                                                response.body);
                                                        print(dic);
                                                        if (dic['status'] ==
                                                            'success') {
                                                          //  blocdata.lodingSINK(false);
                                                          errorDialog(context,
                                                              "ፓስዎርድዎ ተቀይሯል");
                                                        } else {
                                                          //  blocdata.lodingSINK(false);
                                                          errorDialog(context,
                                                              "ፓስዎርድዎ አልተቀየረም.");
                                                        }
                                                      } else {
                                                        //blocdata.lodingSINK(false);
                                                        errorDialog(context,
                                                            "ፓስዎርድዎ ትህክል አይደለም");
                                                      }
                                                      // responseJson = _returnResponse(response, context);
                                                      // print(dic);
                                                    } on Exception {
                                                      //   blocdata.lodingSINK(false);
                                                      errorDialog(context,
                                                          "ኢንትርነት ተቋርጧል");

                                                      throw Exception(
                                                          'ኢንትርነት ተቋርጧል');
                                                    }
                                                  },
                                                  child: const Icon(
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
            )),
      ),
    );
  }
}
