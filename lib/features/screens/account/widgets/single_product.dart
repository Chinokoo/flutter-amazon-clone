import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String? image;
  const SingleProduct({super.key, this.image});

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
            child: image != null
                ? Image.network(
                    image!,
                    fit: BoxFit.fitHeight,
                    width: 180,
                  )
                : const Center(
                    child: Icon(Icons.image_not_supported),
                  ),
          ),
        ));
  }
}
