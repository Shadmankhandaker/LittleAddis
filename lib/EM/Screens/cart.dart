import 'dart:ui';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/ENG/Screens/cart.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/global.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addresspay.dart';

class Cart extends StatefulWidget {
  Cart({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final CartBloc _cartBloc = cartBlock;
  String? totalprice;
  String? strip;
  String? token;
  final Loader loader = new Loader();

  @override
  void initState() {
    super.initState();
    _getCart();
  }

  void _getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    token = preferences.getString(SharedPreferencesKey.JWT_TOKEN);

    if (token != null) {
      _cartBloc.getCartSink(token ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    cartBlock.getCartDeleteStream.listen((event) {
      if (event) {
        loader.hideIndicator(_scaffoldKey.currentContext!);
        errorDialog(
          context,
          "ንጥል ተሰር .ል",
          button: true,
        );
        _cartBloc.getCartSink(token ?? "");
      } else {
        loader.hideIndicator(_scaffoldKey.currentContext!);
        errorDialog(
          context,
          "የእቃ መሰረዝ አልተሳካም",
          button: true,
        );
      }
    });

    _cartBloc.updateCartQuantStream.listen((event) {
      loader.hideIndicator(_scaffoldKey.currentContext!);

      if (event) {
        _cartBloc.getCartSink(token ?? "");
      } else {
        print('የጋሪው ዝመና አልተሳካም');
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.0),
        child: Container(
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyHome()));
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
                            Text(
                              "ጋሪ",
                              style: TextStyle(
                                  color: HexColor('#004851'),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: new GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new Cart()));
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
                                      child: cartCount(context),
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
        ),
      ),
      body: StreamBuilder<CartDataResponseModel>(
          stream: _cartBloc.getCartStream,
          builder: (context, AsyncSnapshot<CartDataResponseModel> snapshot) {
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
                      Colors.yellow.withOpacity(0.20), BlendMode.dstATop),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 0, bottom: 0),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: 60.0,
                                            width: 150.0,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              decoration: new InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.green.shade900,
                                                      width: 2.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.green.shade900,
                                                      width: 2.0),
                                                ),
                                                hintText: 'ኮድ ያስገቡ',
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 10.0, 20.0, 10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Container(
                                            height: 40.0,
                                            width: 140.0,
                                            child: RaisedButton(
                                                color: HexColor("#0e4951"),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                onPressed: () {
                                                  print("ቁልፍ ተጭኗል");
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                    "ኩፖን ይተግብሩ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 4, child: method(context, snapshot)),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),
                        child: Card(
                          margin: EdgeInsets.all(0.0),
                          elevation: 5,
                          child: Container(
                            // height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Text(
                                            'ንዑስ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red),
                                          ),
                                        ),
                                        Container(
                                            child: !snapshot.hasData
                                                ? Container()
                                                : Text(
                                                    '${snapshot.data?.totals?.subtotal}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Text(
                                            'ማጓጓዣ:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red),
                                          ),
                                        ),
                                        Container(
                                            child: !snapshot.hasData
                                                ? Container()
                                                : Text(
                                                    '${snapshot.data?.totals?.shippingTotal}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Text(
                                            'አጠቃላይ ድምር:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red),
                                          ),
                                        ),
                                        Container(
                                            child: !snapshot.hasData
                                                ? Container()
                                                : Text(
                                                    '${snapshot.data?.totals?.total}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Container(
                                            child: RaisedButton(
                                                color: HexColor("#0e4951"),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyHome()),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                    "መግዛትን ይቀጥሉ",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: RaisedButton(
                                            color: HexColor("#0e4951"),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            onPressed: () async {
                                              if (snapshot.hasData) {
                                                if (snapshot.data != null) {
                                                  if (snapshot.data?.items !=
                                                      null) {
                                                    if (snapshot.data!.items!
                                                            .length >
                                                        0) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddressPay(
                                                              cart:
                                                                  snapshot.data,
                                                            ),
                                                          ));
                                                    } else {
                                                      errorDialog(context,
                                                          "በጋሪው ውስጥ ምንም ንጥል አልተገኘም",
                                                          button: true);
                                                    }
                                                  } else {
                                                    errorDialog(context,
                                                        "በጋሪው ውስጥ ምንም ንጥል አልተገኘም",
                                                        button: true);
                                                  }
                                                } else {
                                                  errorDialog(
                                                      context, "የጋሪ ስህተት",
                                                      button: true);
                                                }
                                              } else {
                                                errorDialog(context,
                                                    "እባክዎን ውሂብ በምንጭንበት ጊዜ ይጠብቁ",
                                                    button: true);
                                              }
                                              /*if (totalprice == "null") {
                                                errorDialog(
                                                    context, "Cart is empty");
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddressPay(
                                                              price:
                                                                  totalprice)),
                                                );
                                              }*/
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12, right: 12),
                                              child: Text(
                                                "ጨርሰህ ውጣ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  method(BuildContext context, AsyncSnapshot<CartDataResponseModel> snapshot) {
    return Container(
        child: !snapshot.hasData
            ? Center(
                child: AwesomeLoader(
                  color: Colors.green[900],
                  loaderType: 4,
                ),
              )
            : snapshot.data!.items!.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data?.items?.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: cart(
                            snapshot.data!.items![index], token ?? "", context),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "አሁን ምንም ምርቶች የሉዎትም",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ));
  }

  cart(Items cartProduct, String token, BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 4, bottom: 0, right: 10),
          child: SizedBox(
            height: 130,
            child: Card(
              elevation: 5,
              child: Row(
                children: <Widget>[
                  /*  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Container(
                      height: 130.0,
                      width: 90.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          imageUrl: '', imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          placeholder: (context, url) => Center(
                            child: Container(
                              margin: EdgeInsets.all(35.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    appColorGreen),
                              ),
                            ),
                          ),

                          //errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),*/
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: SizedBox(
                                    width: 150.0,
                                    child: Text(
                                      cartProduct.productName ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                          fontFamily: 'Nexa',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: HexColor('#004851')),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 22,
                                padding: EdgeInsets.all(0),
                                child: FlatButton(
                                  onPressed: () {
                                    if (token != null) {
                                      loader.showIndicator(context);
                                      cartBlock.deleteCartSink(
                                          token, cartProduct.key ?? "");
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.green[900],
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 2),
                                child: Container(
                                  child: Text(
                                    "£ " + (cartProduct.price ?? ""),
                                    style: new TextStyle(
                                        fontFamily: 'Nexa',
                                        fontSize: 15.0,
                                        color: HexColor('#004851')),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Padding(
                                    //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    //   child: Container(
                                    //     child: Text(
                                    //       "Quantity",
                                    //       style: new TextStyle(
                                    //           fontSize: 15.0,
                                    //           color: Colors.red,
                                    //           fontWeight: FontWeight.bold),
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      height: 25,
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        onPressed: () {
                                          loader.showIndicator(
                                              _scaffoldKey.currentContext!);

                                          int _counter =
                                              cartProduct.quantity ?? 0;

                                          if (_counter != 1) {
                                            _counter--;

                                            _cartBloc.updateCartQuant(
                                                token,
                                                cartProduct.key.toString(),
                                                _counter);
                                          }
                                        },
                                        color: HexColor("#0e4951"),
                                        padding:
                                            EdgeInsets.only(top: 2, bottom: 0),
                                        shape: Border.all(
                                            color: HexColor("#0e4951")),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        onPressed: () => {},
                                        color: Colors.white,
                                        padding:
                                            EdgeInsets.only(top: 4, bottom: 0),
                                        shape: Border.all(
                                            color: HexColor("#0e4951")),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                cartProduct.quantity.toString(),
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        onPressed: () {
                                          int _counter =
                                              cartProduct.quantity ?? 0;

                                          if (_counter++ <=
                                              (cartProduct.stockStatus
                                                      ?.stockQuantity ??
                                                  0)) {
                                            loader.showIndicator(
                                                _scaffoldKey.currentContext!);

                                            _cartBloc.updateCartQuant(
                                                token,
                                                cartProduct.key.toString(),
                                                _counter);
                                          } else {
                                            errorDialog(
                                              context,
                                              "የአክሲዮን ገደቡን አልፈዋል",
                                              button: true,
                                            );
                                          }
                                        },
                                        color: HexColor("#0e4951"),
                                        padding:
                                            EdgeInsets.only(top: 2, bottom: 0),
                                        shape: Border.all(
                                            color: HexColor("#0e4951")),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  cartCount(BuildContext context) {
    // cartBlock.cartSink(userID);
    return StreamBuilder<String>(
        stream: cartBlock.cartCountStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: AwesomeLoader(
                loaderType: 4,
                color: appColorGreen,
              ),
            );
          }

          return Text(
            snapshot.data == null ? '0' : snapshot.data ?? "0",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          );
        });
  }
}
