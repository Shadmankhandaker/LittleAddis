import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/EM/Screens/search.dart';
import 'package:love/EM/model/v2/products_response/all_products_response_model.dart'
    as AllResponseModel;
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/global.dart';
import 'package:love/models/cart/add_to_cart_body.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';

class ProductView extends StatefulWidget {
  final AllResponseModel.AllProductsResponseModel? productDetails;

  const ProductView({this.productDetails});

  @override
  ProductDetailsState createState() =>
      ProductDetailsState(productDetails: productDetails);
}

class ProductDetailsState extends State<ProductView> {
  AllResponseModel.AllProductsResponseModel? productDetails;
  final CartBloc _cartBloc = cartBlock;
  final Loader loader = Loader();
  final GlobalKey<ProductDetailsState> _scaffoldKey =
      GlobalKey<ProductDetailsState>();

  String token = "";
  String userRole = "";

  ProductDetailsState({this.productDetails});

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter != 1) _counter--;
    });
  }

  bool visibilityTag = true;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        visibilityTag = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getToken();
  }

  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    _cartBloc.getCartSink(token);

    setState(() {
      userRole = preferences.getString(SharedPreferencesKey.USER_ROLE) ?? "";
    });
  }

  final TextEditingController qty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
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
                      child: SizedBox(
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
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHome()),
                              );
                            }),
                        SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: RaisedButton(
                            elevation: 10,
                            color: Colors.white,
                            textColor: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Search()));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // Replace with a Row for horizontal icon + text
                              children: const <Widget>[
                                Icon(Icons.search),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "ምርቶችን ይፈልጉ",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Cart()));
                          },
                          child: Stack(
                            children: <Widget>[
                              const IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black,
                                ),
                                onPressed: null,
                              ),
                              //  list.length ==0 ? new Container() :
                              Positioned(
                                  child: Stack(
                                children: <Widget>[
                                  Icon(Icons.brightness_1,
                                      size: 25.0, color: Colors.green[800]),
                                  Positioned(
                                      top: 7.0,
                                      right: 7.0,
                                      child: Center(
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
          ),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15.0,
            ),
          ]),
        ),
      ),
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
                Colors.yellow.withOpacity(0.20), BlendMode.dstATop),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: SizedBox(
                  width: 150,
                  height: 170,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl: (productDetails?.images.isNotEmpty ?? false)
                            ? productDetails?.images[0].src
                            : '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: Container(
                            margin: const EdgeInsets.all(35.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green.shade900),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                      // Image.network(
                      //   restImage,
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Container(
                    child: Text(
                      productDetails?.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: HexColor('#004851'),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Container(
                      child: Text(
                        productDetails!.metaData.length > 10
                            ? setPriceFromMetaData(
                                productDetails!.metaData, productDetails!)
                            : (productDetails?.salePrice?.isNotEmpty ?? false)
                                ? "£ " + (productDetails?.salePrice ?? "")
                                : "£ " + (productDetails?.regularPrice ?? ""),
                        style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 15.0,
                            color: HexColor('#004851')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            productDetails?.stockQuantity != null
                ? productDetails?.stockQuantity != 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Container(
                          child: const Text(
                            "(ለሽያጭ የቀረበ እቃ)",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Container(
                          child: const Text(
                            '(ከመጋዘን ተጠናቀቀ)',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Container(
                      child: const Text(
                        "(ከመጋዘን ተጠናቀቀ)",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: Container(
                      child: const Text(
                        "ብዛት",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 40,
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: _decrementCounter,
                      color: Colors.yellow[700],
                      padding: const EdgeInsets.only(top: 2, bottom: 0),
                      shape: Border.all(color: Colors.green.shade900),
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.remove,
                              color: Colors.green[900],
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
                      padding: const EdgeInsets.only(top: 4, bottom: 0),
                      shape: Border.all(color: Colors.green.shade900),
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$_counter',
                              style: const TextStyle(
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
                      onPressed: _incrementCounter,
                      color: Colors.yellow[700],
                      padding: const EdgeInsets.only(top: 2, bottom: 0),
                      shape: Border.all(color: Colors.green.shade900),
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              color: Colors.green[900],
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
            const SizedBox(
              height: 10,
            ),
            /*   SizedBox(
              width: 200.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ProductAddDesc,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: HexColor('#004851'),
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.center),
              ),
            ),

          */
            const SizedBox(
              height: 5,
            ),
            productDetails?.stockQuantity != null
                ? productDetails?.stockQuantity == 0
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                RaisedButton(
                                  elevation: 10,
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {},
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: const <Widget>[
                                      Icon(Icons.shopping_cart),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "ከመጋዘን ተጠናቀቀ",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                RaisedButton(
                                  elevation: 10,
                                  color: Colors.blue[200],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    addToCartApi(
                                        productDetails!, context, _counter);
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: const <Widget>[
                                      Icon(Icons.shopping_cart),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "ወደ ግዢው ቅርጫት ጨምር",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                : Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            RaisedButton(
                              elevation: 10,
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {},
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Replace with a Row for horizontal icon + text
                                children: const <Widget>[
                                  Icon(Icons.shopping_cart),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "ከመጋዘን ተጠናቀቀ",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      elevation: 10,
                      color: Colors.green[900],
                      textColor: Colors.white,
                      onPressed: () {
                        _changed(false, "obs");
                        _changed(true, "tag");
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Replace with a Row for horizontal icon + text
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 40, right: 40),
                            child: Text(
                              "መግለጫ",
                            ),
                          )
                        ],
                      ),
                    ),
                    // RaisedButton(
                    //   elevation: 10,
                    //   color: Colors.yellow[800],
                    //   textColor: Colors.white,
                    //   onPressed: () {
                    //     _changed(true, "obs");
                    //     _changed(false, "tag");
                    //   },
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: new BorderRadius.only(
                    //           topLeft: Radius.circular(15),
                    //           topRight: Radius.circular(15))),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     // Replace with a Row for horizontal icon + text
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(
                    //           "Additional Information",
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                // visibilityTag?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, bottom: 10),
                      child: Text("መግለጫ: ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: HexColor('#004851'),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.center),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 300.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Html(
                              data: productDetails?.description,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                //     : Container(),
                // visibilityObs
                //     ? Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 top: 20, left: 20, bottom: 10),
                //             child: Text("Additional Information :",
                //                 overflow: TextOverflow.ellipsis,
                //                 style: new TextStyle(
                //                   fontSize: 15.0,
                //                   color: HexColor('#004851'),
                //                 ),
                //                 maxLines: 10,
                //                 textAlign: TextAlign.center),
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[
                //               SizedBox(
                //                 width: 300.0,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(
                //                       ProductAddDesc,
                //                       overflow: TextOverflow.ellipsis,
                //                       style: new TextStyle(
                //                         fontSize: 15.0,
                //                         color: HexColor('#004851'),
                //                       ),
                //                       maxLines: 10,
                //                       textAlign: TextAlign.center),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       )
                //     : Container(),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
          ],
        ),
      ),
    );
  }

  String setPriceFromMetaData(List<AllResponseModel.MetaData> metaData,
      AllResponseModel.AllProductsResponseModel products) {
    String price = "";

    for (int i = 0; i < metaData.length; i++) {
      if (userRole == "customer") {
        if (metaData[i].key == "product_role_based_price_customer") {
          print("Customer Type");
          price = "£ " + (metaData[i].value ?? "");
          break;
        }
      } else if (userRole == "Business") {
        if (metaData[i].key == "product_role_based_price_Business") {
          print("Business Type");
          price = "£ " + (metaData[i].value ?? "");
          break;
        }
      }
    }

    if (price.isEmpty) {
      if (products.salePrice?.isNotEmpty ?? false) {
        price = "£ " + (products.salePrice ?? "");
      } else {
        price = "£ " + (products.regularPrice ?? "");
      }
    }

    return price;
  }

  addToCartApi(AllResponseModel.AllProductsResponseModel product,
      BuildContext context, int quantity) async {
    loader.showIndicator(context);
    _cartBloc.cartSinkNew(
        AddToCartBody(productId: product.id.toString(), quantity: quantity),
        token);

    _cartBloc.cartStreamNew.listen((event) async {
      loader.hideIndicator(context);

      if (event == true) {
        errorDialog(
          _scaffoldKey.currentContext!,
          "ወደ ጋሪ ታክሏል ምርት በተሳካ ሁኔታ",
          button: true,
        );

        _cartBloc.getCartSink(token);
      } else {
        errorDialog(
          _scaffoldKey.currentContext!,
          'ወደ ጋሪ ምርት ማከል አልተቻለም',
          button: true,
        );
      }
    });
  }

  cartCount(BuildContext context) {
    return StreamBuilder<String>(
        stream: cartBlock.cartCountStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: const AwesomeLoader(
                loaderType: 4,
                color: appColorGreen,
              ),
            );
          }
          return Text(
            snapshot.data == null ? '0' : snapshot.data.toString(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          );
        });
  }
}
