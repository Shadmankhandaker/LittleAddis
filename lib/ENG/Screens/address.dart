import 'dart:convert';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:love/ENG/Screens/homescreenEng.dart';
import 'package:love/ENG/block/allproduct_bloc.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/ENG/model/cartproduct_model.dart';
import 'package:love/global.dart';
import 'package:love/ENG/block/address_bloc.dart';
import 'package:love/ENG/block/getddress_bloc.dart';
import 'package:love/ENG/model/getAddress_modal.dart';
import 'package:love/utils/color_utils.dart' show HexColor;
import 'package:http/http.dart' as http;

import 'cart.dart';

const String jsonplaceholder = "http://api.thelovegrass.com/api/user_data";

Future<GetAddressModal> fetchInfo() async {
  final response = await http.get(Uri.parse(jsonplaceholder));
  final jsonresponse = json.decode(response.body);

  //return Users.fromJson(jsonresponse);

  return GetAddressModal.fromJson(jsonresponse[0]);
}

class Address extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Address> {
  @override
  void initState() {
    super.initState();
    cartCount(context);
  }

  final TextEditingController username = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAddressBloc.getAddressSink(userID ?? "");
    return Scaffold(
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
                          MaterialPageRoute(builder: (context) => MyHomeEng()));
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
                          icon: Icon(
                            Icons.arrow_back,
                            color: HexColor('#004851'),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      SizedBox(
                        width: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text(
                              "Add New Address",
                              style: TextStyle(
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
                              builder: (BuildContext context) => const Cart()));
                        },
                        child: Stack(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
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
      body: StreamBuilder<GetAddressModal>(
          stream: getAddressBloc.getAddressStream,
          builder: (context, AsyncSnapshot<GetAddressModal> snapshot) {
            if (!snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Container(
                    // height: double.infinity,
                    // width: double.infinity,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: username,
                                      decoration: InputDecoration(
                                        labelText: "Full Name*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    TextFormField(
                                      controller: mobile,
                                      decoration: InputDecoration(
                                        labelText: "Mobile Number*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextFormField(
                                      controller: state,
                                      decoration: InputDecoration(
                                        labelText: "State*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    TextFormField(
                                      controller: pincode,
                                      decoration: InputDecoration(
                                        labelText: "Post code*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    TextFormField(
                                      controller: address,
                                      decoration: InputDecoration(
                                        labelText: "Door number*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    TextFormField(
                                      controller: location,
                                      decoration: InputDecoration(
                                        labelText: "Street*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    TextFormField(
                                      controller: city,
                                      decoration: InputDecoration(
                                        labelText: "City/Country*",
                                        labelStyle: TextStyle(
                                          color: HexColor('#004851'),
                                        ),
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, left: 10),
                                          child: Image.asset(
                                            "assets/images/name.png",
                                            height: 10.0,
                                            width: 10.0,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 30,
                                          left: 20,
                                          right: 20),
                                      child: SizedBox(
                                        width: 300,
                                        child: RaisedButton(
                                            color: HexColor('#0e4951'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            onPressed: () {
                                              _address(context);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, bottom: 15),
                                              child: Text(
                                                "Save Details",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
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
                  ),
                ],
              );
            }
            List<Products> allProduct =
                snapshot.data?.products != null ? snapshot.data!.products : [];
            return allProduct.isNotEmpty
                ? ListView.builder(
                    itemCount: allProduct.length,
                    //scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: _userDetailContainer(context, allProduct[index]),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "Don't have any products now",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
          }),
    );
  }

  void _address(BuildContext context) {
    closeKeyboard();
    if (username.text.isNotEmpty) {
      if (mobile.text.isNotEmpty &&
          pincode.text.isNotEmpty &&
          state.text.isNotEmpty &&
          address.text.isNotEmpty &&
          location.text.isNotEmpty &&
          city.text.isNotEmpty) {
        // Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        //  RegExp regex = new RegExp(pattern);
        if (username.text.length > 3 && mobile.text.length > 4) {
          //  Loader().showIndicator(context);
          addressBloc
              .addressSink(
                  userID ?? "",
                  username.text,
                  mobile.text,
                  pincode.text,
                  state.text,
                  address.text,
                  location.text,
                  city.text,
                  city.text,
                  city.text)
              .then(
            (userResponse) {
              if (userResponse.status == "success") {
                // String userResponseStr = json.encode(userResponse);
                // preferences.setString(
                //     SharedPreferencesKey.LOGGED_IN_USERRDATA,
                //     userResponseStr);
                // Loader().hideIndicator(context);
                addressBloc.dispose();
                errorDialog(
                  context,
                  "Address succesfully added",
                  button: true,
                );
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //     builder: (context) => TabbarScreen(),
                //   ),
                //   (Route<dynamic> route) => false,
                // );
              } else if (userResponse.responseCode == '0') {
                // Loader().hideIndicator(context);
                errorDialog(context, "Error");
              } else {
                // Loader().hideIndicator(context);
                errorDialog(
                    context, "Make sure you have entered right credential");
              }
            },
          );
        } else {
          errorDialog(context, "Make sure you have entered right credential");
        }
      } else {
        errorDialog(context, "Please enter valid credential to continue");
      }
    } else {
      errorDialog(context, "Please enter name");
    }
  }

  Widget _userDetailContainer(BuildContext context, Products products) {
    username.text = products.userName ?? "";
    mobile.text = products.userMobile ?? "";
    pincode.text = products.addressPin ?? "";
    state.text = products.addressState ?? "";
    address.text = products.addressTown ?? "";
    location.text = products.addressType ?? "";
    city.text = products.addressCity ?? "";

    return Container(
      // height: double.infinity,
      // width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          labelText: "Full Name*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: mobile,
                        decoration: InputDecoration(
                          labelText: "Mobile Number*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: state,
                        decoration: InputDecoration(
                          labelText: "Email*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: pincode,
                        decoration: InputDecoration(
                          labelText: "Post code*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                          labelText: "Door number*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: location,
                        decoration: InputDecoration(
                          labelText: "Street*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: city,
                        decoration: InputDecoration(
                          labelText: "City/Country*",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/name.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 30, left: 20, right: 20),
                        child: SizedBox(
                          width: 300,
                          child: RaisedButton(
                              color: HexColor('#0e4951'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {
                                _address(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  "Save Details",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
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
    );
  }

  cartCount(BuildContext context) {
    cartBlock.cartSink(userID ?? "");
    return StreamBuilder<CartProductModel>(
        stream: cartBlock.cartStream,
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
                : snapshot.data!.total_items.toString(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          );
        });
  }
}
