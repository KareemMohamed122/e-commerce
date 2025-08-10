import 'package:flutter/material.dart';

class ProductsHeading extends StatelessWidget {
  const ProductsHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "All Products",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        Text(
          "See more",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF0019FF),
          ),
        ),
      ],
    );
  }
}
