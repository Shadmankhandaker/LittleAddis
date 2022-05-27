import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:love/ENG/Strip/payment_info.dart';
import 'package:love/ENG/model/userorders_model.dart';
import 'package:love/models/address/address_response_model.dart';
import 'package:love/models/cart/cartdata_response_model.dart';
import 'package:love/models/orders/order_place_response_model.dart';
import 'package:love/models/orders/orders_response_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:love/global.dart';
import 'creadit_card_bloc.dart';

class CreditCard extends StatefulWidget {
  final OrdersResponseModel order;

  const CreditCard(this.order);

  @override
  _CreditCardState createState() => _CreditCardState(order);
}

class _CreditCardState extends State<CreditCard> {
  final OrdersResponseModel? order;

  _CreditCardState(this.order);

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController = TextEditingController();
  late var maskFormatterNumber;
  late var maskFormatterExpiryDate;
  late var maskFormatterCvv;
  bool cvv = false;

  @override
  void initState() {
    super.initState();
    maskFormatterNumber = MaskTextInputFormatter(mask: '#### #### #### ####');
    maskFormatterExpiryDate = MaskTextInputFormatter(mask: '##/####');
    maskFormatterCvv = MaskTextInputFormatter(mask: '###');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "PAYMENT",
          style:
              TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.green[900]),
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              // tollsbacknavigation = true;
              setState(() {});
              Navigator.pop(context);
            }),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _creditCradWidget(),
            Container(height: 10.0),
            _cardNumber(),
            Container(height: 10.0),
            _expiryDate(),
            Container(height: 10.0),
            _cvvNumber(),
            Container(height: 10.0),
            _cardHolderNmae(),
            _payNow(),
          ],
        ),
      ),
    );
  }

  Widget _creditCradWidget() {
    return StreamBuilder<String>(
        stream: creditCardBloc.numberStream,
        initialData: "",
        builder: (context, number) {
          return StreamBuilder<String>(
              stream: creditCardBloc.expiryDateStream,
              initialData: "",
              builder: (context, expiryDate) {
                return StreamBuilder<String>(
                    stream: creditCardBloc.nameStream,
                    initialData: "",
                    builder: (context, name) {
                      return StreamBuilder<String>(
                          stream: creditCardBloc.cvvStream,
                          initialData: "",
                          builder: (context, cvvNumber) {
                            return CreditCardWidget(
                              cardBgColor: Colors.green[900]!,
                              cardNumber: number.data!,
                              expiryDate: expiryDate.data!,
                              cardHolderName: name.data!,
                              cvvCode: cvvNumber.data!,
                              showBackView: cvv,
                              onCreditCardWidgetChange:
                                  (CreditCardBrand) {}, //true when you want to show cvv(back) view
                            );
                          });
                    });
              });
        });
  }

  Widget _cardNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: ingenieriaTextfield(
        controller: _cardNumberController,
        inputFormatters: [maskFormatterNumber],
        onChanged: (text) {
          creditCardBloc.numberSink(text ?? "");
        },
        onTap: () {
          setState(() {
            cvv = false;
          });
        },
        hintText: "CARD NUMBER",
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.credit_card, color: Colors.green[900]),
      ),
    );
  }

  Widget _expiryDate() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: ingenieriaTextfield(
        controller: _expiryDateController,
        inputFormatters: [maskFormatterExpiryDate],
        onChanged: (text) {
          creditCardBloc.expiryDateSink(text ?? "");
        },
        onTap: () {
          setState(() {
            cvv = false;
          });
        },
        hintText: "EXPIRY DATE",
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.date_range, color: Colors.green[900]),
      ),
    );
  }

  Widget _cardHolderNmae() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: ingenieriaTextfield(
        controller: _cardHolderNameController,
        onChanged: (text) {
          creditCardBloc.nameSink(text ?? "");
        },
        onTap: () {
          setState(() {
            cvv = false;
          });
        },
        hintText: "CARD HOLDER NAME",
        prefixIcon: Icon(Icons.person, color: Colors.green[900]),
      ),
    );
  }

  Widget _cvvNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: ingenieriaTextfield(
        controller: _cvvCodeController,
        onChanged: (text) {
          creditCardBloc.cvvSink(text ?? "");
        },
        onTap: () {
          setState(() {
            cvv = true;
          });
        },
        hintText: "CVV",
        keyboardType: TextInputType.number,
        inputFormatters: [maskFormatterCvv],
        prefixIcon: Icon(Icons.dialpad, color: Colors.green[900]),
      ),
    );
  }

  Widget _payNow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 0.0, left: 15, right: 15),
            child: SizedBox(
              height: 45,
              // width: 200,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.green[900],
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onPressed: () {
                  String month = maskFormatterExpiryDate
                      .getMaskedText()
                      .toString()
                      .split("/")[0];
                  String year = maskFormatterExpiryDate
                      .getMaskedText()
                      .toString()
                      .split("/")[1];
                  if (int.parse(month) > 12) {
                    errorDialog(context, "You write invalid input");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentInformation(
                            pay: order?.total ?? "",
                            number: maskFormatterNumber
                                .getUnmaskedText()
                                .toString(),
                            month: month,
                            year: year,
                            cvc: maskFormatterCvv.getUnmaskedText().toString(),
                            cardHolder: _cardHolderNameController.text,
                            reorder: '',
                            orderid: order?.id.toString() ?? "",
                            model: order ?? OrdersResponseModel(),
                          ),
                        ));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
