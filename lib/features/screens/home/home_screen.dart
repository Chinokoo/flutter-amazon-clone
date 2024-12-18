import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/screens/home/widgets/address_box.dart';
import 'package:flutter_amazon_clone/features/screens/home/widgets/carousel_image.dart';
import 'package:flutter_amazon_clone/features/screens/home/widgets/deal_of_the_day.dart';
import 'package:flutter_amazon_clone/features/screens/home/widgets/top_categories.dart';
import 'package:flutter_amazon_clone/features/screens/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            //address box widget
            AddressBox(),
            //sized box for spacing
            SizedBox(height: 10),
            //top categories
            TopCategories(),
            //sized box for spacing
            SizedBox(height: 10),
            //carousel image
            CarouselImage(),
            //sized box for spacing
            SizedBox(height: 10),
            //deal of the day.
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
