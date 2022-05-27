import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/ENG/block/repeatOrder_bloc.dart';
import 'package:love/ENG/block/userorders_bloc.dart';
import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Strip/provider/create_customer.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/block/checkout_bloc.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:love/utils/color_utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'provider/apply_charges.dart';
import 'provider/get_token_api.dart';

class PaymentInformation extends StatefulWidget {
  final String? pay;
  final String? number;
  final String? month;
  final String? year;
  final String? cvc;
  final String? cardHolder;
  final String? reorder;
  final String? orderid;
  final OrdersResponseModel? model;

  PaymentInformation(
      {this.pay,
      this.number,
      this.month,
      this.year,
      this.cvc,
      this.cardHolder,
      this.reorder,
      this.orderid,
      this.model});

  @override
  _PaymentInformationState createState() => _PaymentInformationState(
      pay, number, month, year, cvc, cardHolder, '', orderid, this.model);
}

class _PaymentInformationState extends State<PaymentInformation> {
  ScreenshotController screenshotController = ScreenshotController();

  final CheckoutBloc bloc = checkoutBloc;

  final GlobalKey<ScaffoldState> _scaffoldsKey = GlobalKey<ScaffoldState>();
  final String? pay;
  final String? number;
  final String? month;
  final String? year;
  final String? cvc;
  final String? cardHolder;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final String? reorder;
  final String? orderid;
  final OrdersResponseModel? model;

  _PaymentInformationState(this.pay, this.number, this.month, this.year,
      this.cvc, this.cardHolder, this.reorder, this.orderid, this.model);

  int flag = 0;
  ProgressDialog? pr;

  @override
  void initState() {
    flag = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      home: Scaffold(
          key: _scaffoldsKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              "የክፍያ መረጃ",
              style: TextStyle(
                  color: Colors.green[900], fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.green[900]),
                onPressed: () => Navigator.pop(context)),
            centerTitle: true,
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
            child: Column(
              children: <Widget>[
                widget.reorder == "1"
                    ? Expanded(
                        flex: 4,
                        child: StreamBuilder<UserOrdersModel>(
                            stream: userOrdersBloc.userordersStream,
                            builder: (context,
                                AsyncSnapshot<UserOrdersModel> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: AwesomeLoader(
                                    color: Colors.green[900],
                                    loaderType: 4,
                                  ),
                                );
                              }
                              List<Orders> order = snapshot.data?.orders != null
                                  ? snapshot.data?.orders ?? []
                                  : [];
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
                            }))
                    : Expanded(
                        flex: 4,
                        child: method(context, model?.lineItems ?? [])),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: _buildTitle("የሚከፈልበት መጠን"),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: _payNow(),
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
              ],
            ),
          )),
    );
  }

  Widget _buildTitle(String? title) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              title ?? "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
                child: Text(
              pay ?? "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
          )
        ],
      ),
    );
  }

  Widget _payNow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 0.0, left: 15, right: 15),
            child: SizedBox(
              height: 45,
              // width: 200,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.green[900],
                child: Text(
                  "አሁን ይክፈሉ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onPressed: () {
                  pr = new ProgressDialog(context,
                      type: ProgressDialogType.Normal);
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
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400),
                    messageTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                        fontWeight: FontWeight.w600),
                  );

                  pr?.show();
                  double totalAmountDouble = double.parse(pay ?? "");
                  int totalAmount = totalAmountDouble.toInt();

                  print('Cart Details $number $month $year $cvc $cardHolder');

                  getCardToken
                      .getCardToken(number ?? "", month ?? "", year ?? "",
                          cvc ?? "", cardHolder ?? "", context)
                      .then((onValue) {
                    String? token = onValue["id"];

                    print('Token Created');

                    createCutomer
                        .createCutomer(onValue["id"], cardHolder ?? "", context)
                        .then((cust) {
                      print('Customer Created');

                      applyCharges
                          .applyCharges(
                        cust["id"],
                        context,
                        totalAmount.toString(),
                      )
                          .then((_) {
                        print('Applied Charges');

                        order(_scaffoldsKey.currentContext!, token,
                            totalAmountDouble, orderid);
                      });

                      pr?.hide();
                    });
                    pr?.hide();
                  });
                  pr?.hide();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void order(
      BuildContext context, String? token, double amount, String? orderId) {
    bloc
        .checkoutApi(amount.toString(), token ?? "", orderId ?? "")
        .then((value) {
      pr?.hide();
      if (value != null) {
        if (value.success == 200) {
          errorDialog(context, "ክፍያው በተሳካ ሁኔታ ተከናውኗል");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHome()),
          );
        } else {
          errorDialog(context, "ስህተት ተከስቷል። ክፍያዎን ከትእዛዞች ታሪክ ያጠናቅቁ");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHome()),
          );
        }
      } else {
        errorDialog(context, "ክፍያ መፈጸም አልተቻለም");
      }
    });
  }

  method(BuildContext context, List<Line_items> items) {
    if (items != null) {
      return items.length > 0
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {},
                  child: cartItem(items[index]),
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
            );
    }
  }

  cartItem(Line_items cartProduct) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Container(
              height: 150.0,
              child: Row(
                children: <Widget>[
                  /* Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 0, top: 10, bottom: 10),
                    child: Container(
                      height: 100.0,
                      width: 80.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          imageUrl: '',
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          placeholder: (context, url) =>
                              Center(
                                child: Container(
                                  margin: EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        appColorGreen),
                                  ),
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),*/

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
                                cartProduct.name ?? "",
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
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
                                child: Container(
                                  child: Text(
                                    "ኪቲ: " + cartProduct.quantity.toString(),
                                    style: new TextStyle(
                                        fontFamily: 'Nexa',
                                        //  decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        decorationThickness: 2,
                                        fontSize: 15.0,
                                        color: HexColor('#004851')),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
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
                            ],
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
    );
  }

  Widget product(BuildContext context, Orders orders) {
    return orders.order_id == orders.order_id
        ? Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 150.0,
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
                                        borderRadius:
                                            BorderRadius.circular(2.0),
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
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
                                    child: Container(
                                      height: 180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: SizedBox(
                                              width: 150.0,
                                              child: Text(
                                                "የትእዛዝ መታወቂያ: " +
                                                    (orders.order_id ?? ""),
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
                                                "ቀን: " + (orders.date ?? ""),
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
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: SizedBox(
                                                  width: 150.0,
                                                  child: Text(
                                                    "ጠቅላላ ዕቃዎች: " +
                                                        orders.count.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: new TextStyle(
                                                        fontFamily: 'Nexa',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: HexColor(
                                                            '#004851')),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 2),
                                                child: Container(
                                                  child: Text(
                                                    "ጠቅላላ ዋጋ: " +
                                                        "£ " +
                                                        (orders.total ?? ""),
                                                    style: new TextStyle(
                                                        fontFamily: 'Nexa',
                                                        fontSize: 15.0,
                                                        color: HexColor(
                                                            '#004851')),
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
                              Expanded(
                                flex: 1,
                                child: Text(""),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
