import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled2/category_screen/presentation/screens/category_screen.dart';

class CategoryTabNavigator extends StatelessWidget {
  const CategoryTabNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (_) => CategoryScreen());
      },
    );
  }
}
