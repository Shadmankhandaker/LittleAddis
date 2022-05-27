import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/Screens/product_details_page.dart';
import 'package:love/ENG/Screens/view_blogs.dart';
import 'package:love/ENG/block/blog_bloc.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/block/recipe_bloc.dart';
import 'package:love/ENG/model/blog_model.dart';
import 'package:love/global.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/recipe_response_model.dart';
import 'cart.dart';

class ThirdTab extends StatefulWidget {
  @override
  ThirdTabState createState() => ThirdTabState();
}

class ThirdTabState extends State<ThirdTab> {
  final _cartBloc = cartBlock;

  @override
  void initState() {
    recipeblog.recipeSink();
    blogsblog.blogsSink();
    _getCart();
    super.initState();
  }

  void _getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    _cartBloc.getCartSink(token);
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(160),
          child: StreamBuilder<CartDataResponseModel>(
              stream: _cartBloc.getCartStream,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(top: statusBarHeight),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
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
                              IconButton(
                                  icon: const Icon(
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
                              SizedBox(
                                width: 250.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Text(
                                      "Recipes and more",
                                      style: TextStyle(
                                          fontFamily: 'Nexa',
                                          color: HexColor('#004851'),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Cart(),
                                    ),
                                  );
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
                                            size: 25.0,
                                            color: Colors.green[800]),
                                        Positioned(
                                          top: 7.0,
                                          right: 7.0,
                                          child: Center(
                                            child: !snapshot.hasData
                                                ? const AwesomeLoader(
                                                    loaderType: 4,
                                                    color: appColorGreen,
                                                  )
                                                : snapshot.data?.items == null
                                                    ? const Text(
                                                        '0',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : Text(
                                                        '${snapshot.data?.items?.length.toString()}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
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
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 5),
              //   child: SizedBox(
              //     width: 120.0,
              //     height: 50.0,
              //     child: Card(
              //       color: HexColor("#0e4951"),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //       child: Center(
              //           child: Text(
              //         'Blogs',
              //         textAlign: TextAlign.center,
              //         style:
              //             TextStyle(color: HexColor('#FFEBC6'), fontSize: 17),
              //       )),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 230,
              //   child: StreamBuilder<BlogModel>(
              //       stream: blogsblog.blogsStream,
              //       builder: (context, AsyncSnapshot<BlogModel> snapshot) {
              //         if (!snapshot.hasData) {
              //           return Center(
              //             child: AwesomeLoader(
              //               color: HexColor("#0e4951"),
              //               loaderType: 4,
              //             ),
              //           );
              //         }
              //         List<Blogs> blogs = snapshot.data?.blogs != null
              //             ? (snapshot.data?.blogs ?? [])
              //             : [];
              //         return blogs.isNotEmpty
              //             ? ListView.builder(
              //                 itemCount: blogs.length,
              //                 shrinkWrap: true,
              //                 scrollDirection: Axis.horizontal,
              //                 //scrollDirection: Axis.horizontal,
              //                 itemBuilder: (context, int index) {
              //                   return InkWell(
              //                     onTap: () {},
              //                     child: Container(
              //                       margin: const EdgeInsets.only(
              //                           left: 6, right: 6),
              //                       child: allBlogs(
              //                         context,
              //                         blogs[index],
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               )
              //             : const Center(
              //                 child: Text(
              //                   "Coming soon..",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontStyle: FontStyle.italic,
              //                   ),
              //                 ),
              //               );
              //       }),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 140.0,
                  height: 50.0,
                  child: Card(
                    color: HexColor("#0e4951"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                        child: Text(
                      'Recipe',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: HexColor('#FFEBC6'), fontSize: 17),
                    )),
                  ),
                ),
              ),
              StreamBuilder<RecipeResponseModel>(
                stream: recipeblog.recipeStream,
                builder:
                    (context, AsyncSnapshot<RecipeResponseModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: AwesomeLoader(
                        color: HexColor("#0e4951"),
                        loaderType: 4,
                      ),
                    );
                  }
                  List<Output> recipe = snapshot.data?.output != null
                      ? (snapshot.data?.output ?? [])
                      : [];
                  return recipe.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.output.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return allRecie(context, recipe[index]);
                          },
                        )
                      : const Center(
                          child: Text(
                            "Coming soon..",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        );
                },
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => All_Recipe()),
              //     );
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: <Widget>[
              //         Text(
              //           "See all",
              //           style: TextStyle(
              //               color: HexColor("#0e4951"),
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold),
              //         ),
              //         Icon(
              //           Icons.arrow_right,
              //           color: HexColor("#0e4951"),
              //           size: 30.0,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget allBlogs(BuildContext context, Blogs blogs) {
    return Card(
      elevation: 5,
      child: SizedBox(
        width: 180,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 130,
              width: double.infinity,
              child: FittedBox(
                child: Image.network(blogs.image ?? ""),
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 4,
                left: 4,
                right: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    child: Text(
                      blogs.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      child: Text(
                        blogs.slug ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: HexColor("#0e4951"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 70),
                    child: SizedBox(
                      height: 25,
                      child: RaisedButton(
                        color: HexColor("#0e4951"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View_Blogs(
                                      image: blogs.image,
                                      title: blogs.title,
                                      slug: blogs.slug,
                                      content: blogs.content,
                                    )),
                          );
                        },
                        child: const Text(
                          'Read More',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allRecie(BuildContext context, Output recipe) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 0, top: 10, bottom: 10),
                child: SizedBox(
                  height: 150.0,
                  width: 120.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image!,
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(appColorGreen),
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          child: Text(
                            recipe.postTitle ?? "",
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

                      Text(
                        recipe.shortdesc ?? "",
                        style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 10.0,
                            color: HexColor('#004851')),
                        // textAlign: TextAlign.center,
                      ),
                      //                          Padding(
                      //                            padding: const EdgeInsets.only(top: 5),
                      //                            child: SizedBox(
                      //                                width: 200.0,
                      //                                child: Text(recipe.method,
                      //                                    overflow: TextOverflow.ellipsis,
                      //                                    style: new TextStyle(fontFamily: 'Nexa',
                      //                                        fontSize: 14.0,
                      //                                        color: HexColor('#004851')))),
                      //                          ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7, left: 0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SizedBox(
                                width: 110,
                                child: RaisedButton(
                                  color: HexColor("#0e4951"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                          productId: recipe.id ?? "",
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
                            //                                GestureDetector(
                            //                                  onTap: () {
                            //
                            //                                    addtocart(products,context);
                            //
                            //                                  },
                            //                                  child: Padding(
                            //                                    padding: const EdgeInsets.only(top: 8,bottom: 8,left: 25),
                            //                                    child: Icon(
                            //                                      Icons.shopping_cart,
                            //                                      color: Colors.blue,size: 22,
                            //                                    ),
                            //                                  ),
                            //                                ),
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
    );
  }
}
