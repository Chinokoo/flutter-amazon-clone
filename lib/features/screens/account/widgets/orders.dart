import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "see all",
                style: TextStyle(
                    fontSize: 18, color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        //display orders picture here.
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          //TODO:display orders here.
          // child: ListView.builder(
          //   itemCount: 4,
          //   itemBuilder: (context, index){},
          // ),
        )
      ],
    );
  }
}
