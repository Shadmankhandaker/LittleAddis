import 'dart:io';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/color_utils.dart';

Client client = Client();
SharedPreferences? preferences;
const Color appColorGreen = Color(0XFF5DBF4E);
String? userID = '';
String? userRole = '';
String? userType = '';
List<String?> likedRestaurent = [];

String? baseUrl() {
  return 'http://api.thelovegrass.com/api/';
}

String? baseUrl2() {
  return 'http://staging.littleaddis.com';
}

String? consumerKey() {
  return 'ck_e1ccdc2994944c076f662ef32508d0ff0736b5f4';
}

String? consumerSecret() {
  return 'cs_74d68d9b7741293f2a577ebb39418cd170748153';
}

closeKeyboard() {
  return SystemChannels.textInput.invokeMethod('TextInput.hide');
}

dynamic safeQueries(BuildContext context) {
  return (MediaQuery.of(context).size.height >= 812.0 ||
      MediaQuery.of(context).size.height == 812.0 ||
      (MediaQuery.of(context).size.height >= 812.0 &&
          MediaQuery.of(context).size.height <= 896.0 &&
          Platform.isIOS));
}

Widget loader() {
  return Container(
    height: 60,
    width: 60,
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.transparent),
    child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
  );
}

class CustomtextField extends StatelessWidget {
  final TextInputType keyboardType;
  final Function? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function? onEditingComplate;
  final Function? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;

  final Widget? prefixIcon;
  CustomtextField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      readOnly: readOnly,
      textInputAction: textInputAction,
      onTap: () => onTap,
      autofocus: autoFocus,
      maxLines: maxLines,
      onEditingComplete: () => onEditingComplate,
      onSubmitted: (value) => onSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChange,
      style: const TextStyle(color: Colors.blue, fontSize: 15),
      cursorColor: HexColor('#004851'),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
        errorStyle: const TextStyle(color: Colors.white),
        errorText: errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(22),
        ),
        hintText: hintText,
        labelStyle:
            const TextStyle(color: Colors.blue, fontStyle: FontStyle.normal),
        hintStyle:
            const TextStyle(color: Colors.blue, fontStyle: FontStyle.normal),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: appColorGreen, width: 1.8),
          borderRadius: BorderRadius.circular(22),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: appColorGreen, width: 1.8),
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}

class CustomButtom extends StatelessWidget {
  final Color? color;
  final String? title;
  final Function? onPressed;
  const CustomButtom({
    this.color,
    this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      child: Text(
        title ?? "",
        style: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
        ),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: appColorGreen, width: 1.8),
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () => onPressed,
    );
  }
}

Widget customAppBar({String? title, Widget? leading}) {
  return AppBar(
      title: Text(title ?? ""),
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: leading);
}

void errorDialog(BuildContext context, String? message, {bool button = false}) {
  showDialog(
    barrierDismissible: false,
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
            Text(message ?? "", textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: MaterialButton(
                onPressed: button == null
                    ? () => Navigator.pop(context)
                    : () {
                        Navigator.pop(context);
                      },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void forgoterrorDialog(BuildContext context, String? message,
    {bool button = false}) {
  showDialog(
    barrierDismissible: false,
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
            Text(message ?? "", textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: MaterialButton(
                onPressed: button == null
                    ? () => Navigator.pop(context)
                    : () {
                        Navigator.pop(context);
                      },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void payerrorDialog(BuildContext context, String? message,
    {bool button = false}) {
  showDialog(
    barrierDismissible: false,
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
            Text(message ?? "", textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: MaterialButton(
                onPressed: button == null
                    ? () => Navigator.pop(context)
                    : () {
                        Navigator.pop(context);
                      },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class ToastActive {
  showToast({String? msg}) {
    return Fluttertoast.showToast(
      msg: msg ?? "",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class Loader {
  void showIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            const Center(
              child: AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader3,
                color: appColorGreen,
              ),
            )
          ],
        ));
      },
    );
  }

  void hideIndicator(BuildContext context) {
    Navigator.pop(context);
  }
}

Widget topWidget(
  String? title,
  String? content,
) {
  return Column(
    children: <Widget>[
      Center(
        child: Text('$title'),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          '$content',
          textAlign: TextAlign.center,
        )),
      ),
    ],
  );
}

/*
customAlert({BuildContext context,String? title,String? content,int flag,Function ontap})
{
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0,left: 12.0,right: 12.0,bottom: 6.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: title),
                    // ),
                  topwidget(title, content),
                  // flag == 1 ?  Icon(Icons.check_circle_outline,size: 65,color: Colors.green,) : flag == 2 ? Icon(Icons.account_balance,size: 65,color: Colors.red,) : Icon(Icons.remove_circle_outline,size: 65,color: Colors.red,),
                  flag == 0 ? SizedBox(
                          width: 320.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            onPressed: ontap,
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                          ),
                        ) :

                        Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  // height: 45,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                    child: Text('CANCEL',style: TextStyle(color: Colors.white),),
                    onPressed: ontap,
                  ),
                ),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  // height: 45,
                                child: RaisedButton(
                    color: Colors.blue,              
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),              
                    child: Text('CONFIRM',style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      
                    },
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
            ),
          );
    });
}

 */

Widget ingenieriaTextfield(
    {Widget? prefixIcon,
    Function(String?)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    String? hintText,
    Function? onTap,
    TextEditingController? controller,
    int? maxLines,
    TextInputType? keyboardType}) {
  return TextField(
    controller: controller,
    onTap: () => onTap,
    inputFormatters: inputFormatters,
    maxLines: maxLines,
    keyboardType: keyboardType,
    onChanged: onChanged,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      filled: true,
      contentPadding: const EdgeInsets.only(top: 30.0, left: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.0),
      ),
      fillColor: Colors.grey[200],
    ),
  );
}

showAlert({BuildContext? context, String? title, String? content}) {
  return showDialog(
    context: context!,
    barrierDismissible: false,
    builder: (_) => Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 160,
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                // height: MediaQuery.of(context).size.height - 300,
                child: SingleChildScrollView(
                  child: _buildAlertContainer(context, title, content),
                )),
          ),
        ),
      ),
    ),
  );
}

Widget _buildAlertContainer(
    BuildContext context, String? title, String? content) {
  return SizedBox(
    height: 300,
    width: MediaQuery.of(context).size.width - 100,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            title ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        Container(height: 10),
        Text(
          content ?? "",
          style: const TextStyle(fontSize: 18),
        ),
        Container(height: 20),
        SizedBox(
          width: 130,
          height: 45,
          child: MaterialButton(
            child: const Text("OK"),
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}

Widget loading(BuildContext context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black87.withOpacity(0.3),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          height: 80,
          width: MediaQuery.of(context).size.width / 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: JumpingText(
                    'Loading...',
                    style: const TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget loadingDialog(BuildContext context, bool isShowing) {
  if (isShowing) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87.withOpacity(0.3),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            height: 80,
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: JumpingText(
                      'Loading...',
                      style: const TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } else {
    return Container();
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
