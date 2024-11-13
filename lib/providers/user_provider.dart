import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/models/user.dart';

class UserProvider extends ChangeNotifier {
  //user instance
  User _user = User(
    id: "",
    name: "",
    email: "",
    password: "",
    address: "",
    type: "",
    token: "",
  );
  //get the user variable to public
  User get user => _user;
  //set the user variable
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
