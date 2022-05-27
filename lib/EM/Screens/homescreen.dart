import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love/global.dart';
import 'package:love/EM/Screens/second.dart';
import 'package:love/EM/Screens/third.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first.dart';
import 'four.dart';

class MyHome extends StatefulWidget {
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  late TabController controller;

  @override
  void initState() {
    getUserDataFromPrefs();
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 4, vsync: this);
  }

  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userDataStr =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA) ?? "";
    Map<String, dynamic> userData = json.decode(userDataStr);
    print(userData);

    setState(() {
      userID = userData['user_id'];
      userRole = userData['user_role'];
    });
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar

      // Set the TabBar view as the body of the Scaffold
      body: TabBarView(
        // Add tabs as widgets
        children: <Widget>[FirstTab(), SecondTab(), ThirdTab(), FourthTab()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.white,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          indicatorColor: HexColor("#0e4951"),

          tabs: <Tab>[
            Tab(
                // set icon to the tab
                icon: Container(
                    height: 20,
                    child: Image.asset("assets/images/bottom_home.png",
                        color: HexColor("#0e4951"))),
                text: 'ዋናው ገጽ!'

                // Icon(Icons.history, color: Colors.green[900]),text: 'Histoy'

                ),
            Tab(
                icon: Container(
                    height: 20,
                    child: Icon(Icons.assignment, color: HexColor("#0e4951"))),
                text: 'የግብዪዪት ታሪክ'
                // icon: Container(height:20,child: Image.asset("assets/images/bottom_orderhistory.png",color: HexColor("#0e4951"))),text: 'የግብዪዪት ታሪክ'
                ),
            Tab(
                icon: Container(
                    height: 20,
                    child: Image.asset("assets/images/bottom_blog.png",
                        color: HexColor("#0e4951"))),
                text: 'ውይዪት'),
            Tab(
                icon: Container(
                    height: 20,
                    child: Image.asset("assets/images/bottom_profile.png",
                        color: HexColor("#0e4951"))),
                text: 'የዓባልነት መረጃዎች'),
          ],
          labelColor: HexColor("#0e4951"),
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
