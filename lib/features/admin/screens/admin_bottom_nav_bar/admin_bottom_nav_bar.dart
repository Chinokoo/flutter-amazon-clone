import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_amazon_clone/features/admin/screens/admin_home_screens/admin_home_screen.dart';

class AdminBottomNavBar extends StatefulWidget {
  const AdminBottomNavBar({super.key});

  @override
  State<AdminBottomNavBar> createState() => _AdminBottomNavBarState();
}

class _AdminBottomNavBarState extends State<AdminBottomNavBar> {
  //Page index
  int _page = 0;
  //Bottom bar width and border width
  double bottomBarWidth = 43;
  double bottomBarBorderWidth = 5;
//list of pages
  List<Widget> pages = [
    const AdminHomeScreen(),
    const Center(child: Text("Analytics")),
    const Center(child: Text("Orders")),
  ];

//function to update page index
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Home Page
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.post_add_sharp),
              ),
              label: "Posts"),

          // Account Page
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.analytics),
              ),
              label: "Analytics"),

          //Cart Page
          BottomNavigationBarItem(
              icon: badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.transparent),
                badgeContent: Text(
                  "4",
                  style: TextStyle(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
                child: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth),
                    ),
                  ),
                  child: const Icon(Icons.border_outer_rounded),
                ),
              ),
              label: "Orders"),
        ],
      ),
    );
  }
}
