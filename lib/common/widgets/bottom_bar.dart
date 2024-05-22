import 'package:flutter/material.dart';
import 'package:node/constants/global_variable.dart';
import 'package:badges/badges.dart' as badges;
import 'package:node/features/account/screens/account_screen.dart';
import 'package:node/features/home/screens/home_screens.dart';
class BottomBar extends StatefulWidget {
  static const String routeName = '/acutal-home';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  static const double bottomBarWidth = 42;
  static const double bottomBarBorderWidth = 5;
  List<Widget>pages=[
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('Cart Page'),),
  ];
  void updatePage(int page){
    setState(() {
      _page=page;
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
          
          // HOME
          BottomNavigationBarItem(
            
              icon: Container(

            width: bottomBarWidth,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth))),
          child: const Icon(Icons.home_outlined),
          ),
          label: '',
          ),
          // ACCOUNT
           BottomNavigationBarItem(
              icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth))),
          child: const Icon(Icons.person_outline_outlined),
          ),
          label: '',
          ),
          //Cart
           BottomNavigationBarItem(
              icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth))),
          child: const badges.Badge(
 
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.white
            ),
          badgeContent: Text('2'), 
          
            child: Icon(Icons.shopping_cart_outlined)),
          ),
          label: '',
          ),

        ],
      ),
    );
  }
}
