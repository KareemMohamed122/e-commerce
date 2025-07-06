import 'package:flutter/material.dart';

class ProductImageCard extends StatelessWidget {
  final String imagePath;

  const ProductImageCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
        ),
      ),
    );
  }
}
