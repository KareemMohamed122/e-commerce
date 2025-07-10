import 'package:flutter/material.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';

import '../bloc/cart/cart_bloc.dart';
import '../core/injection.dart';
import '../models/product.dart';

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
        backgroundColor: Colors.deepOrange,
        fixedSize: Size(width, height),
      ),
      onPressed: () {
        getIt<CartBloc>().add(AddToCart(product));
      },
      child: Text(
        "ADD",
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
