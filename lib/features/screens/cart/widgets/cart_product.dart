import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/screens/product/screens/product_details.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:flutter_amazon_clone/services/ProductService.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  Productservice productservice = Productservice();

  void increaseQuantity(Product product) {
    if (product.quantity > 0) {
      productservice.addToCart(context: context, product: product);
    } else {
      showSnackBar(
          context: context,
          text: "Cannot add Quantity, The product is out of Stock",
          snakBarColor: Colors.red);
    }
  }

  void decreaseQuantity(Product product) {
    productservice.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart["quantity"];

    final totalinPrice = productCart["quantity"] * product.price;

    void navigateToProductScreen() {
      try {
        if (user.cart.isEmpty) {
          showSnackBar(
            context: context,
            text: "Your cart is empty!",
            snakBarColor: Colors.orange,
          );
          return;
        }
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product);
      } catch (e) {
        showSnackBar(
          context: context,
          text: "Something went wrong. Please try again.",
          snakBarColor: Colors.red,
        );
      }
    }

    return (Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      GestureDetector(
        onTap: navigateToProductScreen,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Image.network(
                product.images.isNotEmpty ? product.images[0] : '',
                fit: BoxFit.fitWidth,
                width: 120,
                height: 120,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //product name
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    //product ratings
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                    ),
                    //product price
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        '\$ ${product.price}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    //Eligible Text
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("Eligible for FREE Shipping"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => increaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                  Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(quantity.toString())),
                  InkWell(
                    onTap: () => decreaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(totalinPrice.toString())
          ],
        ),
      )
    ]));
  }
}
