import 'package:awesome_loader/awesome_loader.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:love/ENG/Screens/addresspay.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/address.dart';
import 'package:love/ENG/Screens/profiledetails.dart';
import 'package:love/ENG/Screens/second.dart';
import 'package:love/ENG/Screens/third.dart';
import 'package:love/ENG/block/profile_bloc.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart' show HexColor;
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';
import 'homescreenEng.dart';

class FourthTab extends StatefulWidget {
  String? userName;
  FourthTab({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FourthTab> {
  final _cartBloc = cartBlock;

  @override
  void initState() {
    super.initState();

    _getCart();
  }

  void _getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    if (token != null) {
      _cartBloc.getCartSink(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    profileBloc.profileSink(userID ?? "");

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: StreamBuilder<CartDataResponseModel>(
            stream: _cartBloc.getCartStream,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.only(top: statusBarHeight),
                child: Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomeEng()));
                          },
                          child: Container(
                              height: 60,
                              child: Image.asset('assets/images/logo.png')),
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomeEng()),
                                  );
                                }),
                            new SizedBox(
                              width: 250.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(
                                          color: HexColor('#004851'),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: new GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new Cart()));
                              },
                              child: new Stack(
                                children: <Widget>[
                                  new IconButton(
                                    icon: new Icon(
                                      Icons.shopping_cart,
                                      color: Colors.black,
                                    ),
                                    onPressed: null,
                                  ),
                                  //  list.length ==0 ? new Container() :
                                  new Positioned(
                                      child: new Stack(
                                    children: <Widget>[
                                      new Icon(Icons.brightness_1,
                                          size: 25.0, color: Colors.green[800]),
                                      new Positioned(
                                        top: 7.0,
                                        right: 7.0,
                                        child: new Center(
                                          child: !snapshot.hasData
                                              ? AwesomeLoader(
                                                  loaderType: 4,
                                                  color: appColorGreen,
                                                )
                                              : snapshot.data?.items == null
                                                  ? Text(
                                                      '0',
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  : Text(
                                                      '${snapshot.data?.items?.length.toString()}',
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: new BoxDecoration(boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0,
                  ),
                ]),
              );
            }),
      ),
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
                Colors.yellow.withOpacity(0.20), BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    /*
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                        height: 150,
                        width: 100,
                        child: StreamBuilder<ProfileModal>(
                            stream: profileBloc.profileStream,
                            builder: (context,
                                AsyncSnapshot<ProfileModal> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: AwesomeLoader(
                                    loaderType: 4,
                                    color: appColorGreen,
                                  ),
                                );
                              }
                              print(snapshot.data.user.email);
                              return Container(
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
                                        Colors.yellow.withOpacity(0.20),
                                        BlendMode.dstATop),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ListView(
                                    children: <Widget>[
                                      _userDetailContainer(
                                          context, snapshot.data.user)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),

                     */

//                    FlatButton.icon(
//                      onPressed: () {},
//                      shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(5.0),
//                      ),
//                      icon: Icon(Icons.edit, color: HexColor('#004851')),
//                      label: Text(
//                        "",
//                        style: TextStyle(
//                            fontWeight: FontWeight.w900,
//                            color: HexColor('#004851')),
//                      ),
//                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondTab()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
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
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        "ORDER HISTORY",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: HexColor('#F9E6C1')),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: HexColor('#F9E6C1'),
                                    ),
                                  ],
                                ),
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
                          MaterialPageRoute(builder: (context) => ThirdTab()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                    padding: const EdgeInsets.only(right: 130),
                                    child: Text(
                                      "BLOG",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: HexColor('#F9E6C1')),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor('#F9E6C1'),
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
                              builder: (context) => AddressPay(from: "fourth")),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                    child: Image.asset(
                                        'assets/images/address.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 100),
                                    child: Text(
                                      "ADDRESS",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: HexColor('#F9E6C1')),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor('#F9E6C1'),
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
                              builder: (context) => ProfileDetails()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      "PROFILE DETAILS",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: HexColor('#F9E6C1')),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor('#F9E6C1'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Text("John Doe", textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _userDetailContainer(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 100,
        width: 100,
        child: CircularProfileAvatar(
          '',
          child: Image.network(user.profile_pic ?? ""),
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
    );
  }
}
