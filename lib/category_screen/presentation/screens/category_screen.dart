import 'package:flutter/material.dart';

import '../../../commonUI/custom_appbar.dart';
import '../../../commonUI/favourite_cart_icons.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _State();
}

class _State extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        height: 72,
        leading: const Icon(
          Icons.search_outlined,
          color: Color(0xFF2F3036),
          size: 20,
        ),
        title: Image.asset("assets/images/home_images/casaforsa.png"),
        actions: const [FavouriteCartIcons()],
      ),
    );
  }
}
