import 'package:flutter/material.dart';

class ProductTotalPrice extends StatelessWidget {
  final int price;
  final int quantity;

  const ProductTotalPrice({
    super.key,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    int total = price * quantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Price",
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(color: Colors.grey, fontSize: 18),
        ),
        const SizedBox(height: 3),
        Text(
          "\$$total",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Colors.deepOrange,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
