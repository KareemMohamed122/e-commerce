import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories;
  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.deepOrange),
            ),
            child: Image.asset(
              width: 40,
              height: 40,
              categories[index],
              fit: BoxFit.fill,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
