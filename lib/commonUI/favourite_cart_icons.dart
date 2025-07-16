import 'package:flutter/material.dart';

class FavouriteCartIcons extends StatelessWidget {
  const FavouriteCartIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 24,
      child: Row(
        children: [
          Icon(
            Icons.favorite_outline_rounded,
            color: Color(0xFF2F3036),
            size: 24,
          ),
          SizedBox(width: 16),
          Icon(Icons.shopping_bag_outlined, color: Color(0xFF2F3036), size: 24),
        ],
      ),
    );
  }
}
