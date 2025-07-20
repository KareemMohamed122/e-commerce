import 'package:flutter/material.dart';
import '../../../commonUI/custom_appbar.dart';
import '../../../commonUI/favourite_cart_icons.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Map<String, String> images = {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            SizedBox(height: 16),
            buildCategoryList(),
          ],
        ),
      ),
    );
  }

  GridView buildCategoryList() {
    return GridView.builder(
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String title = images.keys.toList()[index];
        String path = images.values.toList()[index];
        return buildCategoryCard(title, path);
      },
    );
  }
}

Widget buildCategoryCard(String title, String path) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Opacity(
          opacity: 0.8,
          child: Image.asset(
            path,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
