import 'package:awesome_loader/awesome_loader.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:love/EM/Screens/cart.dart';
import 'package:love/EM/Screens/checkout.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/global.dart';
import 'package:love/ENG/block/address_bloc.dart';
import 'package:love/ENG/block/getddress_bloc.dart';
import 'package:love/ENG/model/getAddress_modal.dart';
import 'package:love/models/address/address_response_model.dart';
import 'package:love/models/cart/cart_response_model.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/login/login_response_model.dart' as LoginData;
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart' show HexColor;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddressPay extends StatefulWidget {
  final CartDataResponseModel? cart;
  String from = "";

  AddressPay({Key? key, this.cart, this.from = ""}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddressPayState(cart, from);
  }
}

class AddressPayState extends State<AddressPay> {
  final CartDataResponseModel? cart;
  String from = "";

  AddressPayState(this.cart, this.from);

  LoginData.Data? userData;
  String token = "";
  final _cartBloc = cartBlock;
  final _addressBloc = addressBloc;

  @override
  void initState() {
    super.initState();

    _getCart();
  }

  void _getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";
    String usrData =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA) ?? "";

    userData = LoginData.Data.fromJson(json.decode(usrData));

    if (token != null) {
      _cartBloc.getCartSink(token);
    }

    if (userData != null) {
      _addressBloc.getAddress(userData?.id ?? 0);
    }
  }

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController postcode = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: StreamBuilder<CartDataResponseModel>(
            stream: _cartBloc.getCartStream,
            builder: (context, AsyncSnapshot<CartDataResponseModel> snapshot) {
              return Container(
                child: Card(
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
                                    builder: (context) => MyHome()));
                          },
                          child: Container(
                              height: 60,
                              child: Image.asset('assets/images/logo.png')),
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: HexColor('#004851'),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                }),
                            new SizedBox(
                              width: 250.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  from == null || from.isEmpty
                                      ? Text(
                                          "አዲስ አድራሻ ያክሉ",
                                          style: TextStyle(
                                              color: HexColor('#0e4951'),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "የአድራሻ ዝርዝሮች",
                                          style: TextStyle(
                                              color: HexColor('#0e4951'),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : Text(
                                                        '${snapshot.data?.items?.length.toString()}',
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                          )),
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
      body: StreamBuilder<AddressResponseModel>(
          stream: _addressBloc.addressDetailController,
          builder: (context, AsyncSnapshot<AddressResponseModel> snapshot) {
            if (snapshot.hasData) {
              return _fields(context,
                  data: snapshot.data ?? AddressResponseModel());
            } else {
              return _fields(context);
            }
          }),
    );
  }

  Widget _fields(BuildContext context, {AddressResponseModel? data}) {
    if (data != null) {
      if (data.firstName != null) {
        firstName.text = data.firstName ?? "";
      }
      if (data.lastName != null) {
        lastName.text = data.lastName ?? "";
      }
      if (data.billing?.phone != null) {
        mobile.text = data.billing?.phone ?? "";
      }
      if (data.billing?.email != null) {
        email.text = data.billing?.email ?? "";
      }
      if (data.billing?.postcode != null) {
        postcode.text = data.billing?.postcode ?? "";
      }
      if (data.billing?.address1 != null) {
        address.text = data.billing?.address1 ?? "";
      }
      if (data.billing?.address2 != null) {
        location.text = data.billing?.address2 ?? "";
      }
      if (data.billing?.city != null) {
        city.text = data.billing?.city ?? "";
      }
    }

    return ListView(
      children: <Widget>[
        Container(
          // height: double.infinity,
          // width: double.infinity,
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: firstName,
                            decoration: new InputDecoration(
                              labelText: "የመጀመሪያ ስም*",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: lastName,
                            decoration: new InputDecoration(
                              labelText: "ያባት ስም*",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: mobile,
                            decoration: new InputDecoration(
                              labelText: "ስልክ ቁጥር*",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            controller: email,
                            decoration: new InputDecoration(
                              labelText: "ኢሜል *",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: postcode,
                            decoration: new InputDecoration(
                              labelText: "የልጥፍ ኮድ *",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: address,
                            decoration: new InputDecoration(
                              labelText: "አድራሻ መስመር 1*",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: location,
                            decoration: new InputDecoration(
                              labelText: "የአድራሻ መስመር 2 *",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: city,
                            decoration: new InputDecoration(
                              labelText: "ከተማ / ሀገር *",
                              labelStyle: TextStyle(
                                color: HexColor('#004851'),
                              ),
                              filled: false,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0, left: 10),
                                child: new Image.asset(
                                  "assets/images/name.png",
                                  height: 10.0,
                                  width: 10.0,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 30, left: 20, right: 20),
                            child: Container(
                              width: 300,
                              child: RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {
                                    _address(
                                        userData?.id.toString() ?? "", context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    child: Text(
                                      "ዝርዝሮችን ያስቀምጡ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  cartCount(BuildContext context, CartDataResponseModel data) {
    return StreamBuilder<CartProductModel>(
        stream: cartBlock.cartStream,
        builder: (context, AsyncSnapshot<CartProductModel> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: AwesomeLoader(
                loaderType: 4,
                color: appColorGreen,
              ),
            );
          }

          return Text(
            snapshot.data?.total_items == null
                ? '0'
                : snapshot.data?.total_items.toString() ?? "",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          );
        });
  }

  void _address(String userId, BuildContext context) {
    closeKeyboard();

    if (firstName.text.isNotEmpty) {
      if (mobile.text.isNotEmpty &&
          postcode.text.isNotEmpty &&
          email.text.isNotEmpty &&
          address.text.isNotEmpty &&
          location.text.isNotEmpty &&
          city.text.isNotEmpty &&
          lastName.text.isNotEmpty) {
        Loader().showIndicator(context);

        _addressBloc
            .putAddress(
                userId,
                firstName.text,
                lastName.text,
                mobile.text,
                email.text,
                postcode.text,
                address.text,
                location.text,
                city.text)
            .then((userResponse) {
          Loader().hideIndicator(context);

          if (userResponse != null) {
            if (userResponse.billing != null) {
              if (from == null || from.isEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Checkout(cart: cart!, address: userResponse),
                    ));
              } else {
                errorDialog(context, "መገለጫ በተሳካ ሁኔታ ዘምኗል", button: true);
              }
            } else {
              errorDialog(context, "አድራሻ ማከል አልተቻለም");
            }
          } else {
            errorDialog(context, "አድራሻ ማከል አልተቻለም");
          }
        });
      } else {
        errorDialog(context, "ለመቀጠል እባክዎ ትክክለኛ ማረጋገጫ ያስገቡ");
      }
    } else {
      errorDialog(context, "እባክዎ ስም ያስገቡ");
    }
  }

  Widget _userDetailContainer(BuildContext context, Products products) {
    firstName.text = products.userName ?? "";
    mobile.text = products.userMobile ?? "";
    postcode.text = products.addressPin ?? "";
    email.text = products.addressState ?? "";
    address.text = products.addressTown ?? "";
    location.text = products.addressType ?? "";
    city.text = products.addressCity ?? "";

    return Container(
      // height: double.infinity,
      // width: double.infinity,
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: firstName,
                        decoration: new InputDecoration(
                          labelText: "ሙሉ ስም*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: mobile,
                        decoration: new InputDecoration(
                          labelText: "ስልክ ቁጥር*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: new InputDecoration(
                          labelText: "ኢሜል *",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: postcode,
                        decoration: new InputDecoration(
                          labelText: "የልጥፍ ኮድ *",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: address,
                        decoration: new InputDecoration(
                          labelText: "የበር ቁጥር *",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: location,
                        decoration: new InputDecoration(
                          labelText: "ጎዳና *",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: city,
                        decoration: new InputDecoration(
                          labelText: "ከተማ / ሀገር *",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10),
                            child: new Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 30, left: 20, right: 20),
                        child: Container(
                          width: 300,
                          child: RaisedButton(
                              color: HexColor('#0e4951'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {
                                _address(
                                    userData?.id.toString() ?? "", context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  "አስቀምጥ እና ቀጥል",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
