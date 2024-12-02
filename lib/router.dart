import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/admin/screens/admin_add_products_screen/admin_add_products.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/features/screens/address/address_screen.dart';
import 'package:flutter_amazon_clone/features/screens/home/category_deals_screen.dart';
import 'package:flutter_amazon_clone/features/screens/home/home_screen.dart';
import 'package:flutter_amazon_clone/features/screens/product/screens/product_details.dart';
import 'package:flutter_amazon_clone/features/screens/search/screens/search_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    //auth screen navigator
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    //bottom navigation bar
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

    //address screen
    case AddressScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AddressScreen());

    //home screen navigator
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    //category screen navigator
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));

    //admin add products screen
    case AdminAddProducts.routName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AdminAddProducts());
    //search page
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    //product details page
    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetails(
                product: product,
              ));

    //default route
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
