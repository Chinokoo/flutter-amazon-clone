import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/screens/account/widgets/account_button.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //1st row of buttons
        Row(
          children: [
            AccountButton(
              text: "Your Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "Turn to Seller",
              onTap: () {},
            ),
          ],
        ),
        //sized box for spacing
        const SizedBox(height: 10),
        //2nd row of buttons
        Row(
          children: [
            AccountButton(
              text: "Log out",
              onTap: () {},
            ),
            AccountButton(
              text: "Your Wish List",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
