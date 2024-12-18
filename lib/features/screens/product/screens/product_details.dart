import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/common/widgets/rating_bar.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/screens/search/screens/search_screen.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:flutter_amazon_clone/services/ProductService.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final Productservice productservice = Productservice();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  //navigate to search
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    if (widget.product.quantity > 0) {
      productservice.addToCart(context: context, product: widget.product);
      setState(() {});
      showSnackBar(
          context: context, text: "added to cart!", snakBarColor: Colors.green);
    } else {
      showSnackBar(
          context: context, text: "Out of Stock", snakBarColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                              top: 10,
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //product id and ratings
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  CustomRatingBar(rating: avgRating)
                ],
              ),
            ),
            // product name
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            //product images in a carousel slider
            CarouselSlider(
                items: widget.product.images.map((i) {
                  return Builder(
                      builder: (BuildContext context) => Image.network(
                            i,
                            fit: BoxFit.contain,
                            height: 200,
                          ));
                }).toList(),
                options: CarouselOptions(viewportFraction: 1, height: 300)),
            //divider
            Divider(
              color: Colors.grey[300],
              // height: 10,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: "Price: ",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '\$${widget.product.price}',
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.red,
                              fontWeight: FontWeight.w500))
                    ]),
              ),
            ),

            //description
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.product.quantity < 10
                  ? widget.product.quantity == 0
                      ? "Out of Stock"
                      : "less than 10 remaining"
                  : "in stock"),
            ),
            //description
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.product.description),
            ),
            //divider
            Divider(
              color: Colors.grey[300],
              // height: 10,
              thickness: 5,
            ),
            // buy now button
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(text: "Buy Now", onTap: () {}),
            ),
            //add to cart
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                  text: "Add to Cart",
                  backgroundColor: Colors.yellow,
                  textColor: Colors.black,
                  onTap: addToCart),
            ),

            //rate this product
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Rate This Product",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            //rating the product
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              itemPadding: const EdgeInsets.all(8),
              allowHalfRating: true,
              direction: Axis.horizontal,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productservice.rateProduct(
                    context: context, product: widget.product, rating: rating);
              },
            )
          ],
        ),
      ),
    );
  }
}
