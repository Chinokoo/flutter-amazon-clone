import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String text,
    required Color snakBarColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: snakBarColor,
      content: Text(text, style: const TextStyle(color: Colors.white))));
}
