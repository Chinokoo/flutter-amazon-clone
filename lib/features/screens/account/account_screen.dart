import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/screens/account/widgets/below_app_bar.dart';
import 'package:flutter_amazon_clone/features/screens/account/widgets/orders.dart';
import 'package:flutter_amazon_clone/features/screens/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: const Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(Icons.notifications_outlined),
                        ),
                        Icon(Icons.search_outlined)
                      ],
                    ))
              ],
            ),
          )),
      body: const Column(
        children: [
          BelowAppBar(),
          TopButtons(),
          //sized box for spacing
          SizedBox(height: 20),

          Orders(),
        ],
      ),
    );
  }
}
