import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../global.dart';
import '../model/recipe_response_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);

  final String productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    getProductDetails();
    super.initState();
  }

  RecipeByIdResponseModel model = RecipeByIdResponseModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.output?.thumbnail != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: model.output?.thumbnail ??
                        'https://littleaddis.com/wp-content/uploads/2020/05/logo-1.png',
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
                )
              : Container(
                  margin: const EdgeInsets.all(35.0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(appColorGreen),
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              model.output?.postTitle ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff00454D),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              model.output?.shortdesc ?? "",
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xff00454D),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: model.output?.steps?.step01 != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 1 : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00454D),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      (model.output?.steps?.step01 ?? "") + "\n",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00454D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: model.output?.steps?.step02 != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 2 : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00454D),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      (model.output?.steps?.step02 ?? "") + "\n",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00454D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: model.output?.steps?.step03 != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 3 : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00454D),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      (model.output?.steps?.step03 ?? "") + "\n",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00454D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: model.output?.steps?.step04 != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 4 : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00454D),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      (model.output?.steps?.step04 ?? "") + "\n",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00454D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: model.output?.steps?.step05 != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 5 : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00454D),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      (model.output?.steps?.step05 ?? "") + "\n",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00454D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getProductDetails() async {
    print("getProductDetails");
    try {
      var response = await http.post(
        Uri.parse('https://thelovegrass.com/wp-json/wl/v1/wp_id_recipe'),
        body: {
          'id': widget.productId,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          model = RecipeByIdResponseModel.fromJson(
            json.decode(response.body),
          );
        });
      }
      print(response.body);
    } catch (ex) {
      ex.toString();
    }
  }
}

class RecipeByIdResponseModel {
  String? code;
  Output? output;

  RecipeByIdResponseModel({this.code, this.output});

  RecipeByIdResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    output = json['output'] != null ? Output.fromJson(json['output']) : null;
  }
}
