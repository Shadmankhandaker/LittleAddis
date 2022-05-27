import 'dart:convert';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love/EM/model/v2/products_response/all_products_response_model.dart'
    as AllResponseModel;
import 'package:love/ENG/Screens/four.dart';
import 'package:love/ENG/Screens/google_sign_in.dart';
import 'package:love/ENG/Screens/productview.dart';
import 'package:love/ENG/Screens/second.dart';
import 'package:love/ENG/Screens/third.dart';
import 'package:love/ENG/block/address_bloc.dart';
import 'package:love/bloc/products_bloc.dart';
import 'package:love/events/products_event.dart';
import 'package:love/events/products_state.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/Screens/search.dart';
import 'package:love/ENG/block/allproduct_bloc.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/models/address/address_response_model.dart';
import 'package:love/models/cart/add_to_cart_body.dart';
import 'package:love/repository/products_repo.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart.dart';
import 'package:love/models/login/login_response_model.dart' as LoginData;

import 'loginscreenEng.dart';

class FirstTab extends StatefulWidget {
  String from = "";

  FirstTab({this.from = ""});

  @override
  FirstTabState createState() => FirstTabState();
}

EdgeInsets globalMargin =
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
TextStyle textStyle = const TextStyle(
  fontSize: 100.0,
  color: Colors.black,
);

class FirstTabState extends State<FirstTab> {
  String from = "";
  String userRole = "";

  FirstTabState({this.from = ""});

  int page = 1;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final CartBloc _cartBloc = cartBlock;
  String token = "";
  LoginData.Data? userData;
  final _addressBloc = addressBloc;
  final productBloc = ProductsBloc(ProductsRepository());

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    productBloc.close();
  }

  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    String usrData =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA) ?? "";

    userData = LoginData.Data.fromJson(json.decode(usrData));

    _cartBloc.getCartSink(token);

    setState(() {
      userRole = preferences.getString(SharedPreferencesKey.USER_ROLE) ?? "";
      allproductblog.productSink(page);
    });

    if (userData != null) _addressBloc.getAddress(userData?.id ?? 0);

    productBloc.add(ProductsFetchEvent("en"));
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    Bloc.observer = ProductsBlocObserver();
    return Scaffold(
      key: scaffoldKey,
      drawer: buildDrawer(context),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.only(top: statusBarHeight),
          child: Card(
            margin: const EdgeInsets.all(0),
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
                                Icons.line_weight,
                                size: 24,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                if (userData != null) {
                                  _addressBloc.getAddress(userData?.id ?? 0);
                                }
                                scaffoldKey.currentState?.openDrawer();
                              }),
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 45.0,
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
                                    "Search Products",
                                    style: TextStyle(fontFamily: 'Nexa'),
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
                    Container(
                      height: 10,
                    )
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
      // drawer: HomeDrawer(),
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
          child: BlocProvider(
            create: (context) => productBloc,
            child: ListBuilder(userRole),
          )),
    );
  }

  buildDrawer(BuildContext context) {
    return SizedBox(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: HexColor('#FEF8EF'),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: StreamBuilder<AddressResponseModel>(
                        stream: _addressBloc.addressDetailController,
                        builder: (context,
                            AsyncSnapshot<AddressResponseModel> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: AwesomeLoader(
                                loaderType: 4,
                                color: appColorGreen,
                              ),
                            );
                          } else {
                            return _userDetailContainer(context,
                                snapshot.data ?? AddressResponseModel());
                          }
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
                              decoration: BoxDecoration(
                                color: HexColor('#004851'),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/profiledetails.png'),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "Profile",
                                          textAlign: TextAlign.center,
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
                                  builder: (context) => const Cart()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#004851'),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/cart.png'),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "Cart",
                                          textAlign: TextAlign.center,
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
                              decoration: BoxDecoration(
                                color: HexColor('#004851'),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/orderhistory.png'),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "Order History",
                                          textAlign: TextAlign.center,
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
                            decoration: BoxDecoration(
                              color: HexColor('#004851'),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                              'assets/images/contact.png'),
                                        )),
                                    Expanded(
                                      child: Text(
                                        "Contact",
                                        textAlign: TextAlign.center,
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
                              decoration: BoxDecoration(
                                color: HexColor('#004851'),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/blog.png'),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "Blog",
                                          textAlign: TextAlign.center,
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
                              signOutGoogle();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => LogInScreenEng(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#004851'),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                                'assets/images/logout.png'),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "Logout",
                                          textAlign: TextAlign.center,
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

  _userDetailContainer(BuildContext context, AddressResponseModel model) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedBox(
                  //   height: 80,
                  //   width: 80,
                  //   child: CircularProfileAvatar(
                  //     '',
                  //     child: Image.network(
                  //       model.avatarUrl ?? "",
                  //       fit: BoxFit.cover,
                  //     ),
                  //     radius: 100,
                  //     backgroundColor: Colors.white,
                  //     borderWidth: 1,
                  //     borderColor: Colors.black,
                  //     elevation: 5.0,
                  //     foregroundColor: Colors.brown.withOpacity(0.5),
                  //     onTap: () {
                  //       print('print');
                  //     },
                  //     showInitialTextAbovePicture: true,
                  //   ),
                  // ),
                  Text(
                    "Name : " + (model.firstName ?? ""),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: HexColor('#004851')),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email : " + (model.email ?? ""),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
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

          if (from != null) {
            if (from.isNotEmpty) {
              return const AwesomeLoader(
                loaderType: 4,
                color: appColorGreen,
              );
            } else {
              return Text(
                snapshot.data == null ? '0' : snapshot.data.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              );
            }
          } else {
            return Text(
              snapshot.data == null ? '0' : snapshot.data.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500),
            );
          }
        });
  }

  clearCart() {}
}

class ListBuilder extends StatelessWidget {
  String userRole = "";
  final CartBloc _cartBloc = cartBlock;
  final List<AllResponseModel.AllProductsResponseModel> _productsList = [];
  final ScrollController _scrollController = ScrollController();

  ListBuilder(this.userRole);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsState &&
          state is ProductLoadingState &&
          _productsList.isEmpty) {
        return Center(
          child: AwesomeLoader(
            color: Colors.green[900],
            loaderType: 4,
          ),
        );
      } else if (state is ProductSuccessState) {
        _productsList.addAll(state.productsList);
        context.bloc<ProductsBloc>().isFetching = false;
      }
      return Stack(children: [
        _productsList.isEmpty && !context.bloc<ProductsBloc>().isFetching
            ? const Center(child: Text("No Data Found"))
            : ListView.builder(
                controller: _scrollController
                  ..addListener(() {
                    if (_scrollController.offset ==
                            _scrollController.position.maxScrollExtent &&
                        !context.bloc<ProductsBloc>().isFetching) {
                      context.bloc<ProductsBloc>()
                        ..isFetching = true
                        ..add(ProductsFetchEvent("en"));
                    }
                  }),
                itemCount: _productsList.length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: product(_productsList[index], context),
                  );
                },
              ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Visibility(
            visible: context.bloc<ProductsBloc>().isFetching,
            child: Center(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Center(
                    child: AwesomeLoader(
                      loaderType: AwesomeLoader.AwesomeLoader3,
                      color: appColorGreen,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]);
    }, listener: (context, state) {
      if (state is ProductsState && state is ProductLoadingState) {
        Center(
          child: AwesomeLoader(
            color: Colors.green[900],
            loaderType: 4,
          ),
        );
      } else if (state is ProductSuccessState) {
        _productsList.addAll(state.productsList);
        context.bloc<ProductsBloc>().isFetching = false;
      }
      return;
    });
  }

  Widget product(AllResponseModel.AllProductsResponseModel products,
      BuildContext context) {
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
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 25, bottom: 20),
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: SizedBox(
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
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 2),
                                  child: Container(
                                    child: Text(
                                      products.metaData.length > 10
                                          ? setPriceFromMetaData(
                                              products.metaData, products)
                                          : (products.salePrice?.isNotEmpty ??
                                                  false)
                                              ? "£ " +
                                                  (products.salePrice ?? "")
                                              : "£ " +
                                                  (products.regularPrice ?? ""),
                                      style: TextStyle(
                                          fontFamily: 'Nexa',
                                          fontSize: 15.0,
                                          color: HexColor('#004851')),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: SizedBox(
                                  child: Text(
                                      products.stockQuantity == 0
                                          ? 'Stock Status: Out of stock'
                                          : 'Stock Status: In Stock',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Nexa',
                                          fontSize: 14.0,
                                          color: HexColor('#004851')))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7, left: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: SizedBox(
                                      width: 110,
                                      child: RaisedButton(
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

  addToCartApi(AllResponseModel.AllProductsResponseModel product,
      BuildContext context) async {
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
      if ((products.salePrice?.isNotEmpty ?? false)) {
        price = "£ " + (products.salePrice ?? "");
      } else {
        price = "£ " + (products.regularPrice ?? "");
      }
    }

    return price;
  }
}

class ProductsBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}
