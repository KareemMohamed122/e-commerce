import 'package:flutter/material.dart';

import '../../../commonUI/label_widget.dart';
import '../../../commonUI/quantity_widget.dart';

class ProductPriceQuantity extends StatelessWidget {
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductPriceQuantity({
    super.key,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWidget(
          label: "Price",
          widget: Text("\$$price", style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
