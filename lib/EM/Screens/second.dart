import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:love/EM/Screens/orderView.dart';
import 'package:love/EM/Strip/credit_card.dart';
import 'package:love/ENG/Screens/addresspay.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/Screens/productview.dart';
import 'package:love/ENG/block/userorders_bloc.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';
import 'homescreen.dart';

class SecondTab extends StatefulWidget {
  @override
  SecondTabState createState() => SecondTabState();
}

EdgeInsets globalMargin =
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
TextStyle textStyle = const TextStyle(
  fontSize: 100.0,
  color: Colors.black,
);

class SecondTabState extends State<SecondTab> {
  final _cartBloc = cartBlock;
  final _ordersBloc = userOrdersBloc;

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

    _ordersBloc.getOrders();
  }

  @override
  Widget build(BuildContext context) {
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
                  margin: EdgeInsets.all(0.0),
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
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHome()),
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
                                      "የትእዛዝ ታሪክ",
                                      style: TextStyle(
                                          fontFamily: 'Nexa',
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
          child: StreamBuilder<List<OrdersResponseModel>>(
              stream: _ordersBloc.allOrdersStream,
              builder:
                  (context, AsyncSnapshot<List<OrdersResponseModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: AwesomeLoader(
                      color: Colors.green[900],
                      loaderType: 4,
                    ),
                  );
                }
                List<OrdersResponseModel> order =
                    snapshot.data != null ? snapshot.data ?? [] : [];
                return order.length > 0
                    ? ListView.builder(
                        itemCount: order.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                            onTap: () {},
                            child: product(context, order[index]),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "ምንም ትዕዛዞች አልተገኙም",
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      );
              })),
    );
  }

  Widget product(BuildContext context, OrdersResponseModel orders) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Container(
              height: 230.0,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 0, top: 0, bottom: 10),
                              child: Container(
                                height: 70.0,
                                width: 70.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.0),
                                  child: Image.asset(
                                      "assets/images/orderlist.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Container(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        width: 150.0,
                                        child: Text(
                                          "የትእዛዝ መታወቂያ: " +
                                              orders.id.toString(),
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: SizedBox(
                                        width: 150.0,
                                        child: Text(
                                          "ቀን: ${DateFormat.yMd().format(DateTime.parse(orders.dateCreated ?? ""))}",
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: SizedBox(
                                            width: 150.0,
                                            child: Text(
                                              "ጠቅላላ ዕቃዎች" +
                                                  (orders.lineItems?.length
                                                          .toString() ??
                                                      "0"),
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
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 2),
                                          child: Container(
                                            child: Text(
                                              "ጠቅላላ ዋጋ: " +
                                                  "£ " +
                                                  (orders.total ?? ""),
                                              style: new TextStyle(
                                                  fontFamily: 'Nexa',
                                                  fontSize: 15.0,
                                                  color: HexColor('#004851')),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 2),
                                          child: Container(
                                            child: Text(
                                              orders.status == "pending"
                                                  ? "የክፍያ ሁኔታ-በመጠባበቅ ላይ"
                                                  : "የክፍያ ሁኔታ: ተከፍሏል} \n"
                                                      "Order Status: ${orders.status}",
                                              style: new TextStyle(
                                                  fontFamily: 'Nexa',
                                                  fontSize: 15.0,
                                                  color: HexColor('#004851')),
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
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                              child: RaisedButton(
                                color: HexColor('#004851'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderView(),
                                      settings: RouteSettings(
                                        arguments: orders,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "ንጥሎችን ይመልከቱ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: orders.status == "pending" ? true : false,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: RaisedButton(
                                  color: HexColor('#004851'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreditCard(orders)));
                                  },
                                  child: Text(
                                    "አሁን ይክፈሉ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
