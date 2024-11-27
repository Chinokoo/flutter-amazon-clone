import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/screens/product/screens/product_details.dart';
import 'package:flutter_amazon_clone/services/home_Service.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  //setting the product variable
  Product? product;

  //initializing the home service
  HomeService homeService = HomeService();

  // @override
  // void initState() {
  //   super.initState();
  //   dealOfTheDay();
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dealOfTheDay();
  }

  void dealOfTheDay() async {
    product = await homeService.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToSearchScreen() {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : product!.name.isEmpty
            ? const SizedBox(
                child: Center(child: Icon(Icons.image_not_supported)),
              )
            : GestureDetector(
                onTap: navigateToSearchScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    // Add deal of the day product image
                    Image.network(product!.images[0],
                        height: 200, width: 235, fit: BoxFit.fitHeight),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    // row of images of the deal of the day
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map((e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              );
  }
}
