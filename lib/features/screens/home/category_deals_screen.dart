import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/screens/product/screens/product_details.dart';
import 'package:flutter_amazon_clone/services/home_Service.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const routeName = "/category-page";
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  //list of products
  List<Product>? products = [];
//instance of home service
  final HomeService homeService = HomeService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchAllProductsByCategory(context, widget.category);
  }

//getting all the products by category.
  fetchAllProductsByCategory(BuildContext context, String category) async {
    products = await homeService.fetchCategories(
        context: context, category: widget.category);
    setState(() {});
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
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep Shopping for ${widget.category}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          products == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : products!.isEmpty
                  ? const Center(
                      child: Text("Products not available."),
                    )
                  : SizedBox(
                      height: 170,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products!.length,
                          padding: const EdgeInsets.only(left: 15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 2,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            final product = products![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductDetails.routeName,
                                    arguments: product);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 130,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(product.images[0]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 0, right: 15),
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
        ],
      ),
    );
  }
}
