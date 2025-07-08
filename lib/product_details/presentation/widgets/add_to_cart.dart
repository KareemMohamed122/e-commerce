import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        fixedSize: const Size(200, 50),
      ),
      onPressed: () {},
      child: const Text("ADD TO CART", style: TextStyle(color: Colors.white)),
    );
  }
}
