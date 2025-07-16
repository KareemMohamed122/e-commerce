import 'package:flutter/material.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';

import '../bloc/cart/cart_bloc.dart';
import '../core/injection.dart';
import '../data/models/product.dart';

class AddToCartButton extends StatelessWidget {
  final double fontSize;
  final double width;
  final double height;
  final Product product;
  const AddToCartButton({
    super.key,
    required this.width,
    required this.height,
    required this.product,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0019FF),
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        //getIt<CartBloc>().add(AddToCart(product));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 12, color: Colors.white),
          SizedBox(width: 8),
          Text(
            "Add to cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
