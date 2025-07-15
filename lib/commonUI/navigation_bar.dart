import 'package:flutter/material.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIconTheme: const IconThemeData(color: Color(0xFF0019FF)),
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xFF71727A),
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "Category",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
