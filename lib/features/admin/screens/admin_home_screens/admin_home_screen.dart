import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Text(
                  "Admin",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
      body: Center(
        child: Text("Admin Home Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Add a Product",
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Icon(
            Icons.add,
            color: GlobalVariables.backgroundColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
