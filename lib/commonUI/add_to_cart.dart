import 'package:flutter/material.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';
import '../bloc/cart/cart_bloc.dart';
import '../core/injection.dart';
import '../data/models/product.dart';

class AddToCartButton extends StatelessWidget {
  final double fontSize;
  final double height;
  final Product product;
  final Widget buttonContent;
  final Color buttonBackgroundColor;
  final Color buttonBorderColor;
  final double buttonBorderWidth;

  const AddToCartButton({
    super.key,
    required this.height,
    required this.product,
    required this.fontSize,
    required this.buttonContent,
    required this.buttonBackgroundColor,
    required this.buttonBorderColor,
    required this.buttonBorderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        fixedSize: Size(double.infinity, height),
        side: BorderSide(color: buttonBorderColor, width: buttonBorderWidth),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        getIt<CartBloc>().add(IncrementQuantity(product));
      },
      child: buttonContent,
    );
  }
}
