import 'dart:convert';
import 'dart:io';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:love/EM/Screens/homescreen.dart';
import 'package:love/ENG/block/cartproduct_bloc.dart';
import 'package:love/global.dart';
import 'package:love/ENG/Screens/changePassword.dart';
import 'package:love/ENG/block/profile_bloc.dart';
import 'package:love/ENG/model/profile_modal.dart';
import 'package:love/models/profile_response/profile_response_model.dart';
import 'package:love/share_preference/preferencesKey.dart';
import 'package:love/utils/color_utils.dart' show HexColor;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:love/models/login/login_response_model.dart' as LoginData;

import 'cart.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Select'),
      Company(2, 'Male'),
      Company(3, 'Female'),
      Company(4, 'Other'),
    ];
  }
}

class _ProfileDetailsState extends State<ProfileDetails> {
  XFile? _image;
  final _cartBloc = cartBlock;
  final _profileBloc = profileBloc;

  Future getImageFromCamera() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  ProgressDialog? pr;

  final List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems = [];
  Company? _selectedCompany;
  bool isLoading = false;

  LoginData.Data? userData;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    _getCart();
    super.initState();
  }

  void _getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString(SharedPreferencesKey.JWT_TOKEN) ?? "";

    String usrData =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA) ?? '';

    userData = LoginData.Data.fromJson(json.decode(usrData));

    _cartBloc.getCartSink(token);
    _profileBloc.getProfileInfo(userData?.id.toString() ?? "");
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = [];
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          icon: Icon(
                            Icons.arrow_back,
                            color: HexColor('#004851'),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      SizedBox(
                        width: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text(
                              "የመገለጫ ዝርዝሮች",
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
      body: Stack(
        children: [
          isLoading == true ? Center(child: loader()) : Container(),
          _designProfile(context),
        ],
      ),
    );
  }

  Widget _designProfile(BuildContext context) {
    return StreamBuilder<ProfileResponseModel>(
        stream: profileBloc.profileInfoStream,
        builder: (context, AsyncSnapshot<ProfileResponseModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: AwesomeLoader(
                loaderType: 4,
                color: appColorGreen,
              ),
            );
          }
          print(snapshot.data?.email);
          return Container(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView(
                children: <Widget>[
                  _userDetailContainer(
                      context, snapshot.data ?? ProfileResponseModel())
                ],
              ),
            ),
          );
        });
  }

  Widget _userDetailContainer(BuildContext context, ProfileResponseModel user) {
    mobile.text = user.billing?.phone ?? "";
    fname.text = user.firstName ?? "";
    lname.text = user.lastName ?? "";
    email.text = user.email ?? "";
    gender.text = '';
    location.text = (user.billing?.address1 ?? "") +
        "," +
        (user.billing?.address2 ?? "") +
        "," +
        (user.billing?.state ?? "") +
        "," +
        (user.billing?.city ?? "") +
        "," +
        (user.billing?.country ?? "");
    date.text = '';

    return Align(
        child: Center(
      child: Column(
        children: <Widget>[
          Container(height: 50.0),
          // _selectPhoto(user),
          FlatButton.icon(
            onPressed: () {
              selectImageSource();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            icon: Icon(Icons.edit, color: HexColor('#004851')),
            label: Text(
              "ስዕል አርትዕ",
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: HexColor('#004851')),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
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
                        controller: fname,
                        decoration: InputDecoration(
                          labelText: "የመጀመሪያ ስም",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/pperson.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: lname,
                        decoration: InputDecoration(
                          labelText: "ያባት ስም",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/pperson.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "ኢሜል",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/pemail.png",
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
                          labelText: "ስልክ ቁጥር",
                          labelStyle: TextStyle(
                            color: HexColor('#004851'),
                          ),
                          filled: false,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: Image.asset(
                              "assets/images/pmobile.png",
                              height: 10.0,
                              width: 10.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),

                      /*    DropdownButton(
                            value: _selectedCompany,
                            items: _dropdownMenuItems,
                            onChanged: onChangeDropdownItem,
                          ),

                       */

                      // TextFormField(
                      //   controller: gender,
                      //   decoration: new InputDecoration(
                      //     labelText: "Gender",
                      //     labelStyle: TextStyle(
                      //       color: HexColor('#004851'),
                      //     ),
                      //     filled: false,
                      //     prefixIcon: Padding(
                      //       padding: EdgeInsets.only(right: 10.0, left: 10),
                      //       child: new Image.asset(
                      //         "assets/images/pgender.png",
                      //         height: 10.0,
                      //         width: 10.0,
                      //         fit: BoxFit.scaleDown,
                      //       ),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.emailAddress,
                      // ),

                      // TextFormField(
                      //   controller: date,
                      //   decoration: new InputDecoration(
                      //     labelText: "Birth Date",
                      //     labelStyle: TextStyle(
                      //       color: HexColor('#004851'),
                      //     ),
                      //     filled: false,
                      //     prefixIcon: Padding(
                      //       padding: EdgeInsets.only(right: 10.0, left: 10),
                      //       child: new Image.asset(
                      //         "assets/images/pdate.png",
                      //         height: 10.0,
                      //         width: 10.0,
                      //         fit: BoxFit.scaleDown,
                      //       ),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.emailAddress,
                      // ),

                      // TextFormField(
                      //   controller: location,
                      //   decoration: new InputDecoration(
                      //     labelText: "Location",
                      //     labelStyle: TextStyle(
                      //       color: HexColor('#004851'),
                      //     ),
                      //     filled: false,
                      //     prefixIcon: Padding(
                      //       padding: EdgeInsets.only(right: 10.0, left: 10),
                      //       child: new Image.asset(
                      //         "assets/images/plocation.png",
                      //         height: 10.0,
                      //         width: 10.0,
                      //         fit: BoxFit.scaleDown,
                      //       ),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: Center(
              child: Opacity(
                //wrap our button in an `Opacity` Widget
                opacity: 0.9, //with 50% opacity
                child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    'የሚስጥር ቁልፍ ይቀይሩ',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePassword()),
                    );
                    //Code to execute when Button is clicked
                    //...
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 50, left: 20, right: 20),
            child: SizedBox(
              width: 300,
              child: RaisedButton(
                  color: HexColor("#0e4951"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    _updatepro(context, user);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "ዝርዝሮችን ያስቀምጡ",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ),

          //Text("John Doe", textAlign: TextAlign.center,)
        ],
      ),
    ));
  }

  Widget _selectPhoto(User user) {
    return SizedBox(
      height: 120,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _image != null
            ? Image.file(
                File(_image!.path),
                fit: BoxFit.cover,
              )
            : SizedBox(
                height: 100,
                width: 100,
                child: CircularProfileAvatar(
                  '',
                  child: Image.network(
                    user.profile_pic ?? "",
                    fit: BoxFit.cover,
                  ),
                  radius: 100,
                  backgroundColor: Colors.white,
                  borderWidth: 1,
                  borderColor: Colors.black,
                  elevation: 5.0,
                  foregroundColor: Colors.brown.withOpacity(0.5),
                  onTap: () {
                    selectImageSource();
                  },
                  showInitialTextAbovePicture: true,
                ),
              ),
      ),
    );
  }

  selectImageSource() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: 10.0),
              const Text("ምስል ይምረጡ", textAlign: TextAlign.center),
              Container(height: 30.0),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  getImageFromCamera();
                },
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.camera_alt,
                      color: appColorGreen,
                    ),
                    Container(width: 10.0),
                    const Text('ካሜራ')
                  ],
                ),
              ),
              Container(height: 15.0),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  getImageFromGallery();
                },
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.storage,
                      color: appColorGreen,
                    ),
                    Container(width: 10.0),
                    const Text('ማዕከለ-ስዕላት')
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _updatepro(BuildContext context, ProfileResponseModel user) {
    closeKeyboard();

    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    pr?.style(message: 'የተወሰነ እድገት በማሳየት ላይ ...');
    pr?.style(
      message: 'እባክዎ ይጠብቁ...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        height: 10,
        width: 10,
        margin: const EdgeInsets.all(5),
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    pr?.show();

    if (_image != null) {
      _profileBloc.uploadProfilePic(File(_image!.path)).then((value) {
        if (value != null) {
          if (value.success == 1) {
            _profileBloc
                .updateProfileInfo(user.id.toString(), fname.text, lname.text,
                    email.text, mobile.text,
                    url: value.body)
                .then((value) {
              pr?.hide();
              if (value != null) {
                if (value.id != null) {
                  errorDialog(context, "መገለጫ በተሳካ ሁኔታ ዘምኗል");
                } else {
                  errorDialog(context, "የተወሰነ ስህተት ተከስቷል");
                }
              } else {
                errorDialog(context, "የተወሰነ ስህተት ተከስቷል");
              }
            });
          } else {
            pr?.hide();
            errorDialog(context, "የተወሰነ ስህተት ተከስቷል");
          }
        } else {
          pr?.hide();
          errorDialog(context, "የተወሰነ ስህተት ተከስቷል");
        }
      }).catchError((onError) {
        print(onError);
        pr?.hide();
      });
    } else {
      _profileBloc
          .updateProfileInfo(user.id.toString(), fname.text, lname.text,
              email.text, mobile.text)
          .then((value) {
        pr?.hide();
        if (value != null) {
          if (value.id != null) {
            errorDialog(context, "መገለጫ በተሳካ ሁኔታ ዘምኗል");
          } else {
            errorDialog(context, "የተወሰነ ስህተት ተከስቷል");
          }
        } else {
          errorDialog(context, "የተወሰነ ስህተት ተከስቷል");
        }
      });
    }
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
}
