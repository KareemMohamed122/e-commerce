import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled2/presentation/search-screen/presentation/screens/search_screen.dart';

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
