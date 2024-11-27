import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  //function to get categories
  Future<List<Product>> fetchCategories(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context).user;
    List<Product> productList = [];
    try {
      // get response
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        "Content-Type": 'application/json; charset=UTF-8',
        "x-auth-token": userProvider.token,
      });
      //if response is success
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            //! what on earth is this?
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(
          context: context, text: e.toString(), snakBarColor: Colors.red);
    }
    return productList;
  }

  //function  to get the deal of the day
  Future<Product> fetchDealOfTheDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
        name: "",
        description: "",
        price: 0,
        quantity: 0,
        category: "",
        images: []);
    try {
      // get response
      http.Response res =
          await http.get(Uri.parse('$uri/api/products/deal-of-day'), headers: {
        "Content-Type": 'application/json; charset=UTF-8',
        "x-auth-token": userProvider.token,
      });
      //if response is success
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // Parse the JSON response body into a Product object
            // This line takes the raw JSON response (res.body)
            // and converts it into a Product instance using the fromJson factory constructor
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackBar(
          context: context, text: e.toString(), snakBarColor: Colors.red);
    }
    return product;
  }
}
