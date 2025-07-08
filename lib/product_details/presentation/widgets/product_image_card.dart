import 'package:flutter/material.dart';

class ProductImageCard extends StatelessWidget {
  final String imagePath;

  const ProductImageCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
          width: double.infinity,
          height: 150,
        ),
      ),
    );
  }
}
