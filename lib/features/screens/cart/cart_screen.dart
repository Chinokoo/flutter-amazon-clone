import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/screens/address/address_screen.dart';
import 'package:flutter_amazon_clone/features/screens/cart/widgets/cart_product.dart';
import 'package:flutter_amazon_clone/features/screens/cart/widgets/carts_total.dart';
import 'package:flutter_amazon_clone/features/screens/home/widgets/address_box.dart';
import 'package:flutter_amazon_clone/features/screens/search/screens/search_screen.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //function to navigate to search screen
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
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
          children: [
            //address widget
            const AddressBox(),
            //total items in cart widget
            const CartsTotal(),
            //proceed to buy
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Proceed to buy (${user.cart.length})items',
                onTap: () {
                  Navigator.pushNamed(context, AddressScreen.routeName);
                },
              ),
            ),
            //sized box for spacing
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            //sized box for spacing
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                })
          ],
        ),
      ),
    );
  }
}
