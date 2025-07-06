import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Details",
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(color: Colors.grey, fontSize: 18),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.deepOrange,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
