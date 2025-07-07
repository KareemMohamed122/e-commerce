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
