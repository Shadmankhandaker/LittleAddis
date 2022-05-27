import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/first.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/Screens/productview.dart';
import 'package:love/ENG/block/userorders_bloc.dart';
import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
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
    userOrdersBloc.userordersSink(userID ?? "");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: StreamBuilder<CartDataResponseModel>(
            stream: _cartBloc.getCartStream,
            builder: (context, snapshot) {
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
                                  Navigator.pop(context);
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
                            Stack(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: HexColor('#004851'),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Cart()));
                                  },
                                ),
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
        child: showOrderList(context),
/*


 */
      ),
    );
  }

  Widget showOrderList(BuildContext context) {
    final OrdersResponseModel orders =
        ModalRoute.of(context)?.settings.arguments as OrdersResponseModel;

    final List<Line_items> todo = orders.lineItems ?? [];

    if (todo != null) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: todo.length,
          itemBuilder: (BuildContext context, int index) {
            String product_id = todo[index].id.toString();
            String product_name = todo[index].name ?? "";
            String product_description = (todo[index].name ?? "") + "ቁ";
            String product_features = (todo[index].name ?? "") + "ዋና መለያ ጸባያት";
            String product_add_desc = (todo[index].name ?? "") + "አክል";
            String product_price = todo[index].price ?? "";
            String product_sale_price = todo[index].price ?? "";
            String product_create_date =
                "${DateFormat.yMd().format(DateTime.parse(orders.dateCreated ?? ""))}";
            String product_image = '';
            return Container(
              key: Key(userID ?? ""),
              // background: Container(color: Colors.red),
              // onDismissed: (direction) async
              //  {
              //   deleteOrder(orderId, index);
              // },
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 150.0,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 0, top: 5, bottom: 10),
                              child: Container(
                                height: 120.0,
                                width: 90.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.0),
                                  child: CachedNetworkImage(
                                    imageUrl: product_image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
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
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  appColorGreen),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/orderlist.png"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 25),
                              child: Container(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        width: 200.0,
                                        child: Text(
                                          product_name,
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
                                      padding:
                                          EdgeInsets.fromLTRB(12, 12, 0, 2),
                                      child: Container(
                                        child: Text(
                                          "ንዑስ: £ ${todo[index].subtotal}",
                                          style: new TextStyle(
                                              fontFamily: 'Nexa',
                                              decorationColor: Colors.red,
                                              decorationThickness: 2,
                                              fontSize: 15.0,
                                              color: HexColor('#004851')),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 12, 0, 2),
                                      child: Container(
                                        child: Text(
                                          "ድምር: £ ${todo[index].total}",
                                          style: new TextStyle(
                                              fontFamily: 'Nexa',
                                              decorationColor: Colors.red,
                                              decorationThickness: 2,
                                              fontSize: 15.0,
                                              color: HexColor('#004851')),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    } else {
      return Center(
        child: Text(" የትእዛዝ ዝርዝር ባዶ ነው",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
      );
    }
  }
}
