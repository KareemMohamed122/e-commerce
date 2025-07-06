import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "assets/images/category_images/fashion.png",
      "assets/images/category_images/furniture.png",
      "assets/images/category_images/jewelry.png",
      "assets/images/category_images/responsive.png",
      "assets/images/category_images/shoes.png",
      "assets/images/category_images/sports.png",
    ];

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.all(15),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.deepOrange),
            ),
            child: Image.asset(
              categories[index],
              fit: BoxFit.cover,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
