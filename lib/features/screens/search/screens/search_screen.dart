import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/screens/home/widgets/address_box.dart';
import 'package:flutter_amazon_clone/features/screens/search/widget/searched_product.dart';
import 'package:flutter_amazon_clone/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search-page";
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  SearchService searchService = SearchService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSearchedProduct();
  }

  void fetchSearchedProduct() async {
    products = await searchService.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  //function to navigate to search screen
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
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
        body: Column(
          children: [
            const AddressBox(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: products == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : products!.isEmpty
                        ? const Center(
                            child: Text("No products found."),
                          )
                        : ListView.builder(
                            itemCount: products!.length,
                            itemBuilder: (context, index) {
                              final product = products![index];
                              return SearchedProduct(product: product);
                            })),
          ],
        ));
  }
}
