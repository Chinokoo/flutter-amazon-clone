import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  //function to a product to database
  void sellProduct({
    required BuildContext context,
    required String productName,
    required String productDescription,
    required double productPrice,
    required int productQuantity,
    required String productCategory,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse('$uri/admin/add-product'),
      );

      request.headers.addAll({
        'x-auth-token': userProvider.user.token,
      });

      request.fields['name'] = productName;
      request.fields['description'] = productDescription;
      request.fields['price'] = productPrice.toString();
      request.fields['quantity'] = productQuantity.toString();
      request.fields['category'] = productCategory;
      //add all the images to the request
      for (int i = 0; i < images.length; i++) {
        var file = await http.MultipartFile.fromPath(
          "images",
          images[i].path,
        );
        request.files.add(file);
      }

      //add product details from the model
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      //show success snackbar
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
                context: context,
                text: "Product added successfully",
                snakBarColor: Colors.green);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(
          context: context, text: e.toString(), snakBarColor: Colors.red);
    }
  }
}
