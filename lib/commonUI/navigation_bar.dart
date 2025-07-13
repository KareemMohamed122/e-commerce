import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled2/commonUI/cart_icon.dart';

class NavigationBarMenu extends StatefulWidget {
  final List<Widget> pages;

  const NavigationBarMenu({super.key, required this.pages});

  @override
  State<NavigationBarMenu> createState() => _NavigationBarMenuState();
}

class _NavigationBarMenuState extends State<NavigationBarMenu> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: widget.pages),
      bottomNavigationBar: Container(
        color: Colors.deepOrange,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.deepOrange,
            color: Colors.grey,
            activeColor: Colors.grey,
            tabBackgroundColor: Colors.white,
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(
                icon: Icons.shopping_cart,
                text: "Cart",
                leading: CartIcon(),
              ),
              GButton(icon: Icons.favorite, text: "Favourites"),
            ],
          ),
        ),
      ),
    );
  }
}
