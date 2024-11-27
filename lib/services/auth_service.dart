import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon_clone/constants/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/models/user.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signing up the user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      //code to sign up the user
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: [],
      );
      //sending an http post request to the server to sign up the user
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
                snakBarColor: Colors.green,
                context: context,
                text: "Account created successfully, Sign in with credentials");
          });
    } catch (e) {
      showSnackBar(
          context: context, text: e.toString(), snakBarColor: Colors.red);
    }
  }

  //signing IN the user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            // set user in the provider
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);

            // Saving the token to shared preferences
            await prefs.setString(
                "x-auth-token", jsonDecode(response.body)["token"]);
            //Navigating to the home screen
            Navigator.pushNamed(
              context,
              BottomBar.routeName,
            );
          });
    } catch (e) {
      showSnackBar(
          context: context, text: e.toString(), snakBarColor: Colors.red);
    }
  }

  //getting the user data
  void getUserData(BuildContext context) async {
    try {
      //creating an shared preference instance
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      //checking if the token is null or empty
      if (token == null || token.isEmpty) {
        prefs.setString("x-auth-token", "");
        return;
      }

      var tokenResponse = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': token
        },
      );

      var response = jsonDecode(tokenResponse.body);

      //if response is true then the token is valid and we can get the user data
      if (response == true) {
        http.Response userDataResponse = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              'x-auth-token': token
            });
        //creating an instance of user provider and setting the user data to it
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        //setting the user data to the user provider
        userProvider.setUser(userDataResponse.body);
      }
    } catch (e) {
      showSnackBar(
          context: context, text: e.toString(), snakBarColor: Colors.red);
    }
  }
}
