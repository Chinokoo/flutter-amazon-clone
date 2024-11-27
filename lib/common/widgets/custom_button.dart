import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  Color backgroundColor;
  Color textColor;
  CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.backgroundColor = GlobalVariables.secondaryColor,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}
