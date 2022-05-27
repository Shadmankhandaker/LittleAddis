import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:love/ENG/Screens/first.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/block/blog_bloc.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/utils/color_utils.dart';

import '../../global.dart';
import 'cart.dart';

class View_Recipe extends StatefulWidget {
  final String? image;
  final String? title;
  final String? ing;
  final String? method;

  View_Recipe({
    this.image,
    this.title,
    this.ing,
    this.method,
  });

  @override
  RecipeState createState() => RecipeState();
}

class RecipeState extends State<View_Recipe> {
  @override
  void initState() {
    blogsblog.blogsSink();
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: Container(
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyHomeEng()));
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
                            Navigator.pop(context);
                          }),
                      new SizedBox(
                        width: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text(
                              "Recipe",
                              style: TextStyle(
                                  fontFamily: 'Nexa',
                                  color: HexColor('#004851'),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: HexColor('#004851'),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new Cart()));
                          }),
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
        ),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                child: Image.network(widget.image ?? ""),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 40, right: 40, bottom: 10),
                child: SizedBox(
                  child: Text(
                    widget.title ?? "",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.green[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Slug',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.ing ?? "",
                              // maxLines: 4,
                              style: new TextStyle(
                                fontSize: 12.0,
                                color: Colors.green[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Content',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.method ?? "",
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.green[900],
                            ),
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
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          );
        });
  }
}
