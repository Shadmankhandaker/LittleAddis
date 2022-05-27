import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love/global.dart';
import 'package:love/EM/Screens/four.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/EM/Screens/loginscreen.dart';
import 'package:love/EM/Screens/productview.dart';
import 'package:love/EM/Screens/search.dart';
import 'package:love/EM/Screens/second.dart';
import 'package:love/EM/Screens/third.dart';
import 'package:love/EM/Screens/view_recipe.dart';
import 'package:love/EM/block/allproduct_bloc.dart';
import 'package:love/EM/block/cartproduct_bloc.dart';
import 'package:love/EM/block/profile_bloc.dart';
import 'package:love/EM/block/recipe_bloc.dart';
import 'package:love/EM/model/allproduct_model.dart';
import 'package:love/EM/model/blog_model.dart';
import 'package:love/EM/model/cartproduct_model.dart';
import 'package:love/EM/model/profile_modal.dart';
import 'package:love/EM/model/recipe_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:love/EM/block/addtocart_bloc.dart';

import 'cart.dart';
import 'drawer.dart';

class All_Recipe extends StatefulWidget {
  @override
  FirstTabState createState() => FirstTabState();
}

EdgeInsets globalMargin =
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
TextStyle textStyle = const TextStyle(
  fontSize: 100.0,
  color: Colors.black,
);

class FirstTabState extends State<All_Recipe> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    recipeblog.recipeSink();
    cartCount(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileBloc.profileSink(userID ?? "");
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          child: Card(
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
                              "የምግብ አሰራር",
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
                            IconButton(
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
          decoration: BoxDecoration(boxShadow: [
            const BoxShadow(
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
        child: StreamBuilder<RecipeModel>(
            stream: recipeblog.recipeStream as Stream<RecipeModel>,
            builder: (context, AsyncSnapshot<RecipeModel> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: AwesomeLoader(
                    color: Colors.green[900],
                    loaderType: 4,
                  ),
                );
              }
              List<Recipes> recipe = snapshot.data?.recipe != null
                  ? snapshot.data?.recipe ?? []
                  : [];
              return recipe.isNotEmpty
                  ? ListView.builder(
                      itemCount: recipe.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // scrollDirection: Axis.horizontal,
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
                      height: 130.0,
                      width: 90.0,
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
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: const AlwaysStoppedAnimation<Color>(
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

                          SizedBox(
                            width: 190,
                            child: Padding(
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
            snapshot.data?.total_items == null
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
