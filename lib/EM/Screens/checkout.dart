import 'dart:convert';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:love/EM/Screens/cart.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/EM/Strip/credit_card.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/global.dart';
import 'package:love/models/address/address_response_model.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/orders/place_order_body.dart' as PlaceOrder;
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  final CartDataResponseModel? cart;
  final AddressResponseModel? address;

  Checkout({Key? key, this.cart, this.address}) : super(key: key);

  @override
  CheckoutPageState createState() => CheckoutPageState(cart, address);
}

class CheckoutPageState extends State<Checkout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final CartDataResponseModel? cart;
  final AddressResponseModel? address;
  final _cartBloc = cartBlock;
  final Loader loader = new Loader();

  CheckoutPageState(this.cart, this.address);

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
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: StreamBuilder<CartDataResponseModel>(
            stream: _cartBloc.getCartStream,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.only(top: statusBarHeight),
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
                          height: 20,
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
                                  Text(
                                    "ጨርሰህ ውጣ",
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
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: HexColor('#0e4951'),
                    size: 36.0,
                  ),
                  Text(
                    'የመላኪያ አድራሻ: ',
                    style: TextStyle(
                        color: HexColor('#0e4951'),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 38, bottom: 25),
              child: Container(
                  width: 10,
                  child: Text(
                    (address?.billing?.address1 ?? "") +
                        "," +
                        (address?.billing?.address2 ?? "") +
                        ",\nተማ: " +
                        (address?.billing?.city ?? ""),
                    maxLines: 2,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          height: 45,
                          child: RaisedButton(
                            elevation: 10,
                            color: HexColor('#0e4951'),
                            textColor: Colors.white,
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => SerchBar()));
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Icon(Icons.edit),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "አድራሻ አርትዕ / ቀይር",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 30),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.loyalty,
                              color: HexColor('#0e4951'),
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'የዋጋ ዝርዝሮች',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: HexColor('#0e4951'),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'ንዑስ ድምር: ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor('#0e4951'),
                              ),
                            ),
                            Text(
                              cart?.totals?.subtotal ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor('#0e4951'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'የመላኪያ ክፍያ: ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor('#0e4951'),
                              ),
                            ),
                            Text(
                              "${cart?.totals?.shippingTotal}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor('#0e4951'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7, bottom: 7, left: 10, right: 10),
                        child: Divider(color: HexColor('#0e4951'), height: .6),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'አጠቃላይ ድምር: ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            Text(
                              cart?.totals?.total ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 50, left: 20, right: 20),
              child: RaisedButton(
                  color: HexColor('#0e4951'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    loader.showIndicator(_scaffoldKey.currentContext!);

                    placeOrder(_scaffoldKey.currentContext!, cart!, address!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "ትዕዛዝ እና ክፍያ ይክፈሉ",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  cartCount(BuildContext context) {
    cartBlock.cartSink(userID ?? "");
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

  placeOrder(BuildContext context, CartDataResponseModel cart,
      AddressResponseModel address) {
    PlaceOrder.Billing billing = new PlaceOrder.Billing();
    PlaceOrder.Shipping shipping = new PlaceOrder.Shipping();

    billing.firstName = address.firstName;
    billing.lastName = address.lastName;
    billing.address1 = address.billing?.address1 ?? "";
    billing.address2 = address.billing?.address2 ?? "";
    billing.city = address.billing?.city ?? "";
    billing.email = address.billing?.email ?? "";
    billing.postcode = address.billing?.postcode ?? "";
    billing.state = address.billing?.state ?? "";
    billing.country = address.billing?.country ?? "";
    billing.phone = address.billing?.phone ?? "";

    shipping.firstName = address.firstName;
    shipping.lastName = address.lastName;
    shipping.address1 = address.shipping?.address1 ?? "";
    shipping.address2 = address.shipping?.address2 ?? "";
    shipping.city = address.shipping?.city ?? "";
    shipping.postcode = address.shipping?.postcode ?? "";
    shipping.state = address.shipping?.state ?? "";
    shipping.country = address.shipping?.country ?? "";

    cartBlock
        .placeOrder(billing, shipping, cart.items ?? [], cart)
        .then((value) {
      loader.hideIndicator(context);
      if (value != null) {
        if (value.id != null) {
          Navigator.push(
              context,
              NoAnimationMaterialPageRoute(
                  builder: (context) => CreditCard(value)));
        } else {
          errorDialog(context, 'ትዕዛዝ መስጠት አልተቻለም \n እባክዎ እንደገና ይሞክሩ',
              button: true);
        }
      } else {
        errorDialog(context, 'ትዕዛዝ መስጠት አልተቻለም \n እባክዎ እንደገና ይሞክሩ',
            button: true);
      }
    });
  }
}
