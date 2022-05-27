import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:love/global.dart';
import 'package:love/global.dart';
import 'package:love/EM/Screens/second.dart';
import 'package:love/EM/Screens/third.dart';
import 'package:love/EM/block/profile_bloc.dart';
import 'package:love/EM/model/profile_modal.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';
import 'four.dart';
import 'loginscreen.dart';

class BuildDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    profileBloc.profileSink(userID ?? "");
    return SizedBox(
      //  width: MediaQuery.of(context).size.width - 100,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: HexColor('#FEF8EF'),
              child: Column(
                children: <Widget>[
                  //  _userDetailContainer(context),

                  SizedBox(
                    height: 200,
                    child: StreamBuilder<ProfileModal>(
                        stream:
                            profileBloc.profileStream as Stream<ProfileModal>,
                        builder:
                            (context, AsyncSnapshot<ProfileModal> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: AwesomeLoader(
                                loaderType: 4,
                                color: appColorGreen,
                              ),
                            );
                          }
                          print(snapshot.data?.user?.email);
                          return _userDetailContainer(
                              context, snapshot.data?.user ?? User());
                        }),
                  ),

                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FourthTab()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 30),
                            child: Container(
                              color: HexColor('#004851'),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/profiledetails.png'),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        child: Text(
                                          "የዓባልነት መረጃዎች",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: HexColor('#F9E6C1')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Cart()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              color: HexColor('#004851'),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/cart.png'),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 80),
                                        child: Text(
                                          "የገበያ ዘንቢል",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: HexColor('#F9E6C1')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondTab()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              color: HexColor('#004851'),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/orderhistory.png'),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 65),
                                        child: Text(
                                          "የግብዪዪት ታሪክ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: HexColor('#F9E6C1')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Container(
                            color: HexColor('#004851'),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 7, bottom: 7),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                              'assets/images/contact.png'),
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 120),
                                      child: Text(
                                        "አድራሻ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: HexColor('#F9E6C1')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ThirdTab()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              color: HexColor('#004851'),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/blog.png'),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 116),
                                        child: Text(
                                          "ውይዪት",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: HexColor('#F9E6C1')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences
                                .remove(
                                    SharedPreferencesKey.LOGGED_IN_USERRDATA)
                                .then((_) {
                              likedRestaurent = [];
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => LogInScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              color: HexColor('#004851'),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/logout.png'),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 80),
                                        child: Text(
                                          "ጨርሸ ልውጣ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: HexColor('#F9E6C1')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
/*
            StreamBuilder<ProfileModal>(
            stream: profileBloc.profileStream,
                builder: (context, AsyncSnapshot<ProfileModal> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: AwesomeLoader(
                        loaderType: 4,
                        color: appColorGreen,
                      ),
                    );
                  }
                 // print(snapshot.data.user.email);
                  return
                })

 */
          ],
        ),
      ),
    );
  }

  _userDetailContainer(BuildContext context, User user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 45.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    child: CircularProfileAvatar(
                      '',
                      child: Image.network(
                        user.profile_pic ?? "",
                        fit: BoxFit.cover,
                      ),
                      radius: 100,
                      backgroundColor: Colors.white,
                      borderWidth: 1,
                      borderColor: Colors.black,
                      elevation: 5.0,
                      foregroundColor: Colors.brown.withOpacity(0.5),
                      onTap: () {
                        print('print');
                      },
                      showInitialTextAbovePicture: true,
                    ),
                  ),
                  Text(
                    user.fname ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: HexColor('#004851')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
