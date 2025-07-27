import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled2/category_screen/presentation/screens/category_screen.dart';
import 'package:untitled2/search-screen/presentation/screens/search_screen.dart';

class SearchTabNavigator extends StatelessWidget {
  const SearchTabNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (_) => SearchScreen());
      },
    );
  }
}
