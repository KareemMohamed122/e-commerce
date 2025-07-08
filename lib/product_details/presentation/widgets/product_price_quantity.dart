import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commonUI/label_widget.dart';
import '../../../commonUI/quantity_widget.dart';
import '../manager/product_details_controller.dart';

class ProductPriceQuantity extends StatelessWidget {
  final double price;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductPriceQuantity({
    super.key,
    required this.price,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductDetailsController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LabelWidget(
          label: "Price",
          widget: Text(
            "\$${price.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                "QUANTITY",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 4),
            QuantityWidget(onRemove: onRemove, onAdd: onAdd),
          ],
        ),
      ],
    );
  }
}
