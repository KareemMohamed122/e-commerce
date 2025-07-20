import 'package:flutter/material.dart';

import '../../../commonUI/custom_appbar.dart';
import '../../../commonUI/favourite_cart_icons.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _State();
}

class _State extends State<CategoryScreen> {
  Map<String, String> images = {
    "Bedroom": "assets/images/category_images/bedroom.jpg",
    "Living Room": "assets/images/category_images/livingroom.jpg",
    "Kitchen": "assets/images/category_images/kitchen.jpg",
    "Office": "assets/images/category_images/office.jpg",
  };
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              Flexible(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            images.values.toList()[index],
                            width: 165,
                            height: 165,
                            color: Colors.transparent,
                          ),
                        ),
                        Positioned(
                          right: 32,
                          left: 32,
                          child: Text(
                            images.keys.toList()[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
