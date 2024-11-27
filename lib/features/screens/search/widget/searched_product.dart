import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/rating_bar.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/screens/product/screens/product_details.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0.0;

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product);
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.fitWidth,
                  width: 135,
                  height: 135,
                ),
                Column(
                  children: [
                    //product name
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    //product ratings
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: CustomRatingBar(rating: avgRating),
                    ),
                    //product price
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        '\$${product.price}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    //Eligible Text
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("Eligible for FREE Shipping"),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        product.quantity == 0 ? "Out of Stock" : "In Stock",
                        style: TextStyle(
                            color: product.quantity == 0
                                ? Colors.red
                                : Colors.teal),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
