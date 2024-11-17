import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/services/auth_service.dart';

//enum to switch btwn radio button options
enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //variable to store the selected radio button option
  Auth _auth = Auth.signup;
  //`GlobalKey` to access the form in the `build` method
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

// auth service to handle authentication logic
  final AuthService authService = AuthService();

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //dispose method to dispose the controllers to avoid memory leaks.
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //method to handle sign up form submission
  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  //method to handle sign in form submission
  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // auth title
              const Text(
                'Welcome to Amazon Clone',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              //sized box for spacing

              //radio button for sign in or sign up
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  'Create an Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
              ),
              //sign up form
              if (_auth == Auth.signup)
                Form(
                    key: _signUpFormKey,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Column(
                        children: [
                          CustomTextfield(
                            obscureText: false,
                            controller: _nameController,
                            hintText: "Name",
                          ),
                          //sized box for spacing
                          const SizedBox(height: 10),
                          CustomTextfield(
                              obscureText: false,
                              controller: _emailController,
                              hintText: "Email"),
                          //sized box for spacing
                          const SizedBox(height: 10),
                          CustomTextfield(
                              obscureText: true,
                              controller: _passwordController,
                              hintText: "Password"),
                          //sized box for spacing
                          const SizedBox(height: 10),
                          CustomButton(
                              text: "Sign Up",
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              }),
                        ],
                      ),
                    )),

              //radio button for sign up
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  'Sign in to your Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
              ),
              //sign in form
              if (_auth == Auth.signin)
                Form(
                    key: _signInFormKey,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Column(
                        children: [
                          CustomTextfield(
                              obscureText: false,
                              controller: _emailController,
                              hintText: "Email"),
                          //sized box for spacing
                          const SizedBox(height: 10),
                          CustomTextfield(
                              obscureText: true,
                              controller: _passwordController,
                              hintText: "Password"),
                          //sized box for spacing
                          const SizedBox(height: 10),
                          CustomButton(
                              text: "Sign In",
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              }),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      )),
    );
  }
}
