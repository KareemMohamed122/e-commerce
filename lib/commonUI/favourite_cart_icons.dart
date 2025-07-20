import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:untitled2/commonUI/cart_icon.dart';

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
          CartIcon(),
        ],
      ),
    );
  }
}
