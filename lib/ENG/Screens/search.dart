import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:love/EM/model/v2/products_response/all_products_response_model.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/productview.dart';
import 'package:love/ENG/block/search_bloc.dart';
import 'package:love/models/cart/add_to_cart_body.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchBloc = searchBloc;
  final CartBloc _cartBloc = cartBlock;

  final TextEditingController searchController = TextEditingController();
  bool isSearch = false;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      _searchBloc.searchProducts(searchController.text);
    });
  }

  getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    _cartBloc.getCartSink(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          height: double.infinity,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomeEng()));
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
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 0.0, right: 0.0),
                          child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Colors.black,
                              ),
                              onPressed: () => Navigator.pop(context)),
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 0.0),
                            child: CustomtextField(
                              onChange: (value) {
                                setState(() {
                                  isSearch = true;
                                });
                                searchBloc.searchSink(value);
                              },
                              suffixIcon: InkWell(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                },
                                child: IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              autoFocus: true,
                              controller: searchController,
                              maxLines: 1,
                              hintText: 'Search Products',
                            ),
                          ),
                        ),
                        Container(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Cart()));
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
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width,
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
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(height: 10.0),
              !isSearch
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Search Products.",
                        style: TextStyle(
                          color: HexColor('#004851'),
                          fontSize: 18,
                        ),
                      ),
                    )
                  : _searchListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchListView() {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      height: MediaQuery.of(context).size.height - 200,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: StreamBuilder<List<AllProductsResponseModel>>(
        stream: searchBloc.searchResult,
        builder:
            (context, AsyncSnapshot<List<AllProductsResponseModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: AwesomeLoader(
                color: appColorGreen,
                loaderType: 4,
              ),
            );
          }
          // List<search.SearchRestaurants> allRest = snapshot.data.restaurants;
          List<AllProductsResponseModel> allProd =
              snapshot.data != null ? (snapshot.data ?? []) : [];
          return allProd.isNotEmpty
              ? ListView.builder(
                  itemCount: allProd.length,
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductView(
                              ProductID: allProd[index].product_id,
                              ProductName:
                              allProd[index].product_name,
                              ProductFeatures:
                              allProd[index].product_features,
                              ProductImage:
                              allProd[index].product_image,
                              ProductDesc:
                              allProd[index].product_description,
                              ProductAddDesc:
                              allProd[index].product_add_desc,
                              ProductSalePrice:
                              allProd[index].product_sale_price,
                              ProductPrice:
                              allProd[index].product_price,
                               Product_whole_sale: allProd[index].whole_sale,
                               Product_stock: allProd[index].stock,
                            ),
                          ),
                        );*/
                      },
                      child: product(allProd[index], context),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "Don't have any Product",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget product(AllProductsResponseModel products, BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: SizedBox(
              height: 180.0,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 0, top: 10, bottom: 10),
                    child: SizedBox(
                      height: 130.0,
                      width: 90.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          imageUrl: products.images[0].src!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: Container(
                              margin: const EdgeInsets.all(35.0),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    appColorGreen),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25),
                    child: SizedBox(
                      height: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: 200.0,
                              child: Text(
                                products.name ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Nexa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: HexColor('#004851')),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          /*Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Container(
                              child: Text(
                                "(" + products.product_features + ")",
                                style: new TextStyle(
                                    fontFamily: 'Nexa',
                                    fontSize: 10.0,
                                    color: HexColor('#004851')),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),*/
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 2),
                                  child: Container(
                                      child: (products.salePrice?.isNotEmpty ??
                                              false)
                                          ? Text(
                                              '£ ${products.regularPrice}',
                                              style: TextStyle(
                                                fontFamily: 'Nexa',
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: Colors.red,
                                                decorationThickness: 2,
                                                fontSize: 15.0,
                                                color: HexColor('#004851'),
                                              ),
                                            )
                                          : null)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 2),
                                child: Container(
                                  child: Text(
                                    (products.salePrice?.isNotEmpty ?? false)
                                        ? "£ " + (products.salePrice ?? "")
                                        : "£ " + (products.regularPrice ?? ""),
                                    style: TextStyle(
                                        fontFamily: 'Nexa',
                                        fontSize: 15.0,
                                        color: HexColor('#004851')),
                                  ),
                                  /*child: userRole == "0"
                                      ? Text(
                                          products.salePrice.isNotEmpty ?
                                          "£ " + products.salePrice : "£ " + products.regularPrice,
                                          style: new TextStyle(
                                              fontFamily: 'Nexa',
                                              fontSize: 15.0,
                                              color: HexColor('#004851')),
                                        )
                                      : userRole == "1"
                                          ? Text(
                                              products.attributes[0].name ==
                                                      'whole_sale'
                                                  ? "£ " +
                                                      products.attributes[0]
                                                          .options.first
                                                  : null,
                                              style: new TextStyle(
                                                  fontFamily: 'Nexa',
                                                  fontSize: 15.0,
                                                  color: HexColor('#004851')),
                                            )
                                          : Container(),*/
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                                width: 200.0,
                                child: Text(products.shortDescription ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Nexa',
                                        fontSize: 14.0,
                                        color: HexColor('#004851')))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 20),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: SizedBox(
                                    width: 110,
                                    child: RaisedButton(
                                      //color: HexColor("#882424"),
                                      color: HexColor("#0e4951"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductView(
                                              productDetails: products,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        // Replace with a Row for horizontal icon + text
                                        children: const <Widget>[
                                          Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 3),
                                            child: Text(
                                              "Quick View",
                                              style: TextStyle(
                                                  fontFamily: 'Nexa',
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (products.stockQuantity == null) {
                                      errorDialog(
                                        context,
                                        "Out of Stock",
                                        button: true,
                                      );
                                    } else {
                                      if (products.stockQuantity > 0) {
                                        addToCartApi(products, context);
                                      } else {
                                        errorDialog(
                                          context,
                                          "Out of Stock",
                                          button: true,
                                        );
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 25),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: HexColor("#0e4951"),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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

  addToCartApi(AllProductsResponseModel product, BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    Loader().showIndicator(context);
    _cartBloc.cartSinkNew(
        AddToCartBody(productId: product.id.toString(), quantity: 1), token);

    _cartBloc.cartStreamNew.listen((event) async {
      Loader().hideIndicator(context);

      if (event == true) {
        errorDialog(
          context,
          "Product added to cart Successfully",
          button: true,
        );

        _cartBloc.getCartSink(token);
      } else {
        errorDialog(
          context,
          'Unable to add product to cart',
          button: true,
        );
      }
    });
  }

  cartCount(BuildContext context) {
    return StreamBuilder<String>(
        stream: _cartBloc.cartCountStream,
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
