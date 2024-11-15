import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Container(
            width: 180,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/mobiles.jpeg",
              fit: BoxFit.fitHeight,
              width: 180,
            ),
          ),
        ));
  }
}
