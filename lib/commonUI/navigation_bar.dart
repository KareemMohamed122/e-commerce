import 'package:flutter/material.dart';
import 'package:untitled2/commonUI/search_tab_navigator.dart';
import '../home_page/presentation/screens/home_screen.dart';
import 'category_tab_navigator.dart';

class NavigationBarMenu extends StatefulWidget {
  final int currentIndex;

  const NavigationBarMenu({super.key, required this.currentIndex});

  @override
  State<NavigationBarMenu> createState() => _NavigationBarMenuState();
}

class _NavigationBarMenuState extends State<NavigationBarMenu> {
  late int currentIndex;

  final List<Widget> pages = [
    HomeScreen(),
    SearchTabNavigator(),
    CategoryTabNavigator(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: SizedBox(
        height: 88,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedIconTheme: const IconThemeData(color: Color(0xFF0019FF)),
          unselectedIconTheme: const IconThemeData(color: Color(0xFFD4D6DD)),
          selectedItemColor: Color(0xFF1F2024),
          unselectedItemColor: const Color(0xFF71727A),
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD4D6DD),
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, size: 20),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 20),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded, size: 20),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 20),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
