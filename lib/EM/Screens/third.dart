import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:love/global.dart';
import 'package:love/EM/Screens/all_recipe.dart';
import 'package:love/EM/Screens/homescreen.dart';

import 'package:love/EM/Screens/view_blogs.dart';
import 'package:love/EM/Screens/view_recipe.dart';
import 'package:love/EM/block/blog_bloc.dart';
import 'package:love/EM/block/cartproduct_bloc.dart';
import 'package:love/EM/block/recipe_bloc.dart';
import 'package:love/EM/model/blog_model.dart';
import 'package:love/EM/model/cartproduct_model.dart';
import 'package:love/EM/model/recipe_model.dart';
import 'package:love/utils/color_utils.dart';

import 'cart.dart';

class ThirdTab extends StatefulWidget {
  @override
  ThirdTabState createState() => ThirdTabState();
}

class ThirdTabState extends State<ThirdTab> {
  @override
  void initState() {
    recipeblog.recipeSink();
    blogsblog.blogsSink();
    cartCount(context);
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Container(
          margin: EdgeInsets.only(top: statusBarHeight),
          child: Card(
            margin: const EdgeInsets.all(0.0),
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
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyHome()),
                            );
                          }),
                      SizedBox(
                        width: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text(
                              "ብሎግ እና የምግብ አሰራር",
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
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                width: 120.0,
                height: 50.0,
                child: Card(
                  color: HexColor("#0e4951"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text(
                    'ውይዪት',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HexColor('#FFEBC6'), fontSize: 17),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 230,
              child: StreamBuilder<BlogModel>(
                  stream: blogsblog.blogsStream as Stream<BlogModel>,
                  builder: (context, AsyncSnapshot<BlogModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: AwesomeLoader(
                          color: HexColor("#0e4951"),
                          loaderType: 4,
                        ),
                      );
                    }
                    List<Blogs> blogs = snapshot.data?.blogs != null
                        ? snapshot.data?.blogs ?? []
                        : [];
                    return blogs.isNotEmpty
                        ? ListView.builder(
                            itemCount: blogs.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            //scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: allBlogs(context, blogs[index]),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              "አሁን ምንም ምርቶች የልዎትም",
                              style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                  }),
            ),
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
                    'ዓሰራር/ዓዘገጃጀት',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HexColor('#FFEBC6'), fontSize: 17),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: StreamBuilder<RecipeModel>(
                  stream: recipeblog.recipeStream as Stream<RecipeModel>,
                  builder: (context, AsyncSnapshot<RecipeModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: AwesomeLoader(
                          color: HexColor("#0e4951"),
                          loaderType: 4,
                        ),
                      );
                    }
                    List<Recipes> recipe = snapshot.data?.recipe != null
                        ? snapshot.data?.recipe ?? []
                        : [];
                    return recipe.isNotEmpty
                        ? ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            //scrollDirection: Axis.vertical,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: allRecie(context, recipe[index]),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              "አሁን ምንም ምርቶች የልዎትም",
                              style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => All_Recipe()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "ሁሉንም ዓሳይ!",
                      style: TextStyle(
                          color: HexColor("#0e4951"),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: HexColor("#0e4951"),
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),

            /*
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: 110,
                            child: RaisedButton(
                              color: Colors.green[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12)),
                              onPressed: () {
                              },
                              child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[

                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 13),
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                          fontFamily: 'Nexa',
                                          color: Colors.white,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
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
                  ),
                ),

                 */

/*
                        Padding(
                          padding: const EdgeInsets.only(top:5),
                          child: SizedBox(
                            width: 140.0,
                            height: 50.0,
                            child: Card(
                              color: Colors.green[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                  child: Text(
                                    'Cookery Video',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: HexColor('#FFEBC6'), fontSize: 17),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 15,
                            itemBuilder: (BuildContext context, int index) => Card(
                              elevation: 5,
                              child: Container(
                                height: 180.0,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 150.0,
                                        width: 95.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://thelovegrass.com/wp-content/uploads/2019/11/1000x1000-Crisply-Flakes.png"))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 180,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(5, 2, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                    child: Container(
                                                      child: Text(
                                                        "TEFF FUSILLI",
                                                        style: new TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15.0,
                                                            color:
                                                            Colors.green[900]),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                child: Container(
                                                  child: Text(
                                                    "(Made from 100% White Teff)",
                                                    style: new TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.green[900]),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.fromLTRB(0, 5, 0, 2),
                                                child: Container(
                                                  width: 50,
                                                  child: Text(
                                                    "£ 2.00",
                                                    style: new TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.green[900]),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: 200.0,
                                                  child: Text(
                                                      'PRODUCERS CAVITY FIGHTER 50X140g',
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: new TextStyle(
                                                          fontSize: 18.0,
                                                          color:
                                                          Colors.green[900]))),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 0, 2),
                                                child: Container(
                                                  width: 140,
                                                  child: RaisedButton(
                                                    color: Colors.green[900],
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductView()),
                                                      );
                                                      print("Button Is Pressed");
                                                    },
                                                    child: Row(
                                                      // Replace with a Row for horizontal icon + text
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.remove_red_eye,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                          child: Text(
                                                            "Quick View",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.white),
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

 */
          ],
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
              //   height: 180,
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
                    padding: const EdgeInsets.only(top: 10, left: 60),
                    child: SizedBox(
                      height: 25,
                      child: RaisedButton(
                        color: Colors.blue,
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
                          print("Button Is Pressed");
                        },
                        child: const Text(
                          'ተጨማሪ ማብራሪያ',
                          style: TextStyle(color: Colors.white, fontSize: 12),
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

  Widget allRecie(BuildContext context, Recipes recipe) {
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
                                recipe.title ?? "",
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

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: SizedBox(
                              child: Text(
                                recipe.ing ?? "",
                                maxLines: 4,
                                style: TextStyle(
                                    fontFamily: 'Nexa',
                                    fontSize: 10.0,
                                    color: HexColor('#004851')),
                                // textAlign: TextAlign.center,
                              ),
                            ),
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
                            padding: const EdgeInsets.only(top: 7, left: 20),
                            child: Row(
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
                                              builder: (context) => View_Recipe(
                                                    image: recipe.image,
                                                    title: recipe.title,
                                                    ing: recipe.ing,
                                                    method: recipe.method,
                                                  )),
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
                                              "ፈጣን እይታ",
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
        ),
      ],
    );
  }

  cartCount(BuildContext context) {
    cartBlock.cartSink(userID ?? "");
    return StreamBuilder<CartProductModel>(
        stream: cartBlock.cartStream as Stream<CartProductModel>,
        builder: (context, AsyncSnapshot<CartProductModel> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: const AwesomeLoader(
                loaderType: 4,
                color: appColorGreen,
              ),
            );
          }

          return Text(
            snapshot.data!.total_items == null
                ? '0'
                : snapshot.data?.total_items.toString() ?? "",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          );
        });
  }
}
