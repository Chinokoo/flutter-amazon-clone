import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address-page";
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // key for the form
  final addressFormKey = GlobalKey<FormState>();

  //controllers for the form
  final TextEditingController _houseNumber = TextEditingController();

  final TextEditingController _street = TextEditingController();

  final TextEditingController _postalCode = TextEditingController();

  final TextEditingController _city = TextEditingController();

  String addressToBeUsed = "";
  @override
  void dispose() {
    _houseNumber.dispose();
    _street.dispose();
    _postalCode.dispose();
    _city.dispose();
    super.dispose();
  }

  void onGooglePayResult(Map<String, dynamic> result) {}

  void payPressed(String addressFromProvider) {
    addressToBeUsed =
        "${_street.text}, ${_city.text}, ${_houseNumber.text} - ${_postalCode.text}";
    bool isForm = _houseNumber.text.isNotEmpty ||
        _street.text.isNotEmpty ||
        _postalCode.text.isNotEmpty ||
        _city.text.isNotEmpty;

    if (isForm) {
      if (addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_street.text}, ${_city.text}, ${_postalCode.text}, ${_houseNumber.text}';
      } else {
        throw Exception("Please enter all the values !");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context: context, text: "Error!", snakBarColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    //getting the user address from provider.
    final address = context.watch<UserProvider>().user.address;

    final user = context.watch<UserProvider>().user;
    final userCart = user.cart;
    int sum = 0;

    for (int i = 0; i < userCart.length; i++) {
      sum += userCart[i]['quantity'] * (userCart[i]['product']['price'].toInt())
          as int;
    }

    List<PaymentItem> paymentItems = [
      PaymentItem(
          amount: sum.toString(),
          label: "Total Amount",
          status: PaymentItemStatus.final_price)
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            address.isEmpty
                ? const Text("Please add your address")
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          address,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[800]),
                        ),
                      ),
                      //sized box for spacing
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(fontSize: 22, color: Colors.grey[600]),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //sized box for spacing
                  const SizedBox(
                    height: 20,
                  ),
                  //form to enter the address box
                  Form(
                    key: addressFormKey,
                    child: Column(
                      children: [
                        //house number text field
                        CustomTextfield(
                            controller: _houseNumber,
                            hintText: "Flat, House no., Building,"),
                        //sized box for spacing
                        const SizedBox(
                          height: 10,
                        ),
                        //street text field
                        CustomTextfield(
                            controller: _street, hintText: "Area, Street"),
                        //sized box for spacing
                        const SizedBox(
                          height: 10,
                        ),
                        //postal code text field
                        CustomTextfield(
                            controller: _postalCode, hintText: "Postal Code"),
                        //sized box for spacing
                        const SizedBox(
                          height: 10,
                        ),
                        //city text field
                        CustomTextfield(
                            controller: _city, hintText: "Town/City"),
                        //sized box for spacing
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  GooglePayButton(
                    //onPressed: ,//() => payPressed(address),
                    paymentConfiguration:
                        //just bear with me for now until i find a way to put this in another file
                        PaymentConfiguration.fromJsonString('''
{
                    "provider": "google_pay",
                    "data": {
                      "environment": "TEST",
                      "apiVersion": 2,
                      "apiVersionMinor": 0,
                      "allowedPaymentMethods": [
                        {
                          "type": "CARD",
                          "parameters": {
                            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
                            "allowedCardNetworks": ["VISA", "MASTERCARD"]
                          },
                          "tokenizationSpecification": {
                            "type": "PAYMENT_GATEWAY",
                            "parameters": {
                              "gateway": "example",
                              "gatewayMerchantId": "exampleGatewayMerchantId"
                            }
                          }
                        }
                      ],
                      "merchantInfo": {
                        "merchantName": "Example Merchant"
                      },
                      "transactionInfo": {
                        "totalPriceStatus": "FINAL",
                        "totalPrice": "0.00",
                        "currencyCode": "USD"
                      }
                    }
}
'''),
                    paymentItems: paymentItems,
                    onPaymentResult: onGooglePayResult,
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15),
                    type: GooglePayButtonType.buy,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
